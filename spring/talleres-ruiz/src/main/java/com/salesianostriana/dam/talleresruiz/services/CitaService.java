package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.*;
import com.salesianostriana.dam.talleresruiz.models.Adjunto;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaCreateCliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaEditMecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.repositories.CitaRepository;
import com.salesianostriana.dam.talleresruiz.repositories.AdjuntoRepository;
import com.salesianostriana.dam.talleresruiz.repositories.MecanicoRepository;
import com.salesianostriana.dam.talleresruiz.search.spec.cita.CitaSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.talleresruiz.services.ficheros.FileSystemStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.net.URI;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

@Service
@RequiredArgsConstructor
public class CitaService {

    private final CitaRepository repository;
    private final AdjuntoRepository adjuntoRepository;
    private final FileSystemStorageService storageService;
    private final MecanicoRepository mecanicoRepository;

    public List<Cita> findAll() {
        List<Cita> result = repository.findAll();
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen citas");
        }
        return result;
    }

    public Page<Cita> findAll(Specification<Cita> spec, Pageable pageable) {
        Page<Cita> result = repository.findAll(spec, pageable);
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen citas");
        }
        return result;
    }

    public Cita findById(Long id) {
        return repository.findById(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra la cita con ID: " + id));
    }

    public Cita add(Cita cita) {
        return repository.save(cita);
    }

    public Cita edit(Long id, CitaEditMecanico edit, Mecanico mecanico) {
        return repository.findById(id)
                .map(cita -> {
                    if (Objects.equals(cita.getEstado(), "Terminada")) {
                        throw new OperacionDenegadaException("No se puede modificar una cita en este estado");
                    }
                    if (cita.getMecanico() == null) {
                        cita.setMecanico(mecanico);
                    }
                    cita.setFechaHora(edit.getFechaHora());
                    cita.setEstado(edit.getEstado());
                    return repository.save(cita);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra la cita con ID: " + id));
    }

    public Cita editCliente(UUID idCliente, Long idCita, CitaCreateCliente edit) {
        return repository.findById(idCita)
                .map(cita -> {
                    if (cita.getCliente().getId() != idCliente) {
                        throw new OperacionDenegadaException("La cita no pertenece al cliente especificado");
                    } else if (Objects.equals(cita.getEstado(), "Terminada")) {
                        throw new OperacionDenegadaException("No se puede modificar una cita en este estado");
                    } else if (Objects.equals(cita.getEstado(), "Aceptada")) {
                        cita.setEstado("Trámite");
                    }
                    cita.setFechaHora(edit.getFechaHora());
                    return repository.save(cita);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra la cita con ID: " + idCita));
    }

    public void delete(Long id) {
        if (repository.existsById(id)) {
            Cita cita = this.findById(id);
            if (cita.getEstado().equalsIgnoreCase("Proceso") || cita.getEstado().equalsIgnoreCase("Terminada")) {
                throw new OperacionDenegadaException("No se puede cancelar una cita en proceso de realización o terminada");
            }
            cita.borrarCliente(cita.getCliente());
            borrarFicheros(cita);
            repository.delete(cita);
        }
    }

    public void deleteCliente(Long idCita, UUID idCliente) {
        if (repository.existsById(idCita)) {
            Cita cita = this.findById(idCita);
            if (!Objects.equals(cita.getCliente().getId(), idCliente) ||
                    cita.getEstado().equalsIgnoreCase("Proceso") ||
                    cita.getEstado().equalsIgnoreCase("Terminada")) {
                throw new OperacionDenegadaException("No se puede cancelar una cita en proceso de realización, " +
                        "terminada, o que no perteneza al usuario");
            }
            cita.borrarCliente(cita.getCliente());
            borrarFicheros(cita);
            repository.delete(cita);
        }
    }

    public void borrarFicheros(Cita cita) {
        cita.getChat().forEach(adjunto -> {
            if (adjunto.isFichero()) {
                storageService.deleteFile(adjunto.getContenido());
            }
        });
    }

    public void setearNullMecanico(Mecanico mecanico) {
        repository.findByMecanico(mecanico).forEach(cita -> {
            cita.setMecanico(null);
        });
    }

    public PageDto<CitaDto> paginarFiltrarCitas(String search, Pageable pageable) {
        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(search);

        CitaSpecificationBuilder citaSpecification = new CitaSpecificationBuilder(params);
        Specification<Cita> spec = citaSpecification.build();

        Page<CitaDto> resultDto = this.findAll(spec, pageable).map(this::generarCitaDto);

        return new PageDto<CitaDto>(resultDto);
    }

    @Transactional
    public Cita mostrarCitaConChat(UUID idUsuario, Long idCita) {
        Cita cita = repository.findByIdChat(idCita).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra la cita con ID: " + idCita));
        if (cita.getCliente().getId().equals(idUsuario) || mecanicoRepository.existsById(idUsuario)) {
            return cita;
        } else {
            throw new OperacionDenegadaException("La cita no pertenece al usuario que intenta acceder");
        }
    }

    public boolean validarFechaHora(LocalDateTime fechaHora) {
        LocalTime horaCita = LocalTime.of(fechaHora.getHour(), fechaHora.getMinute());
        return fechaHora.getDayOfWeek().getValue() != 6
                && fechaHora.getDayOfWeek().getValue() != 7
                && !horaCita.isBefore(LocalTime.of(7, 30))
                && !horaCita.isAfter(LocalTime.of(15, 30));
    }

    public void comprobarEstadoAutor(Long idCita, UUID idAutor, int op) {
        Cita cita = this.findById(idCita);
        if (!cita.getCliente().getId().equals(idAutor) && !cita.getMecanico().getId().equals(idAutor)) {
            throw new OperacionDenegadaException("La cita no pertenece al usuario que intenta enviar el mensaje");
        } else if (cita.getMecanico() == null) {
            throw new OperacionDenegadaException("No se puede enviar hasta que no se asigne un mecánico");
        }
        if ((cita.getEstado().equalsIgnoreCase("Terminada") && op == 1) ||
                ((cita.getEstado().equalsIgnoreCase("Terminada") || cita.getEstado().equalsIgnoreCase("Proceso"))
                        && op == 2)) {
            throw new OperacionDenegadaException("No se puede modificar una cita en este estado");
        }
    }

    public CitaDto generarCitaDto(Cita cita) {
        CitaDto citaDto = repository.generarCitaDto(cita.getId());
        citaDto.setMecanico(cita.getMecanico() != null ? cita.getMecanico().getUsuario().getNombre() : "Por asignar");
        citaDto.setCliente(cita.getCliente().getUsuario().getNombre());
        return citaDto;
    }

    public CitaDto generarCitaDtoDetails(Cita cita) {
        CitaDto citaDto = repository.generarCitaDtoDetails(cita.getId());
        if (!cita.getChat().isEmpty()) {
            citaDto.setChat(adjuntoRepository.generarChatDto(cita.getId()));
        }
        return citaDto;
    }

    public CitaDto modifCitaMec(Cita cita) {
        CitaDto citaDto = repository.generarCitaDtoDetails(cita.getId());
        if (!cita.getChat().isEmpty()) {
            citaDto.setChat(adjuntoRepository.generarChatDto(cita.getId()));
        }
        cita.setMecanico(mecanicoRepository.findByNombre(citaDto.getMecanico()));
        return citaDto;
    }

    public CitaDto citaCliente(Cita cita) {
        CitaDto citaDto = generarCitaDto(cita);
        if (cita.getMecanico() == null) {
            citaDto.setMecanico("Por asignar");
        } else {
            citaDto.setMecanico(cita.getMecanico().getUsuario().getNombre());
        }
        citaDto.setId(citaDto.getId());
        return citaDto;
    }

    public ResponseEntity<CitaDto> crearCita(CitaDto citaDto) {
        URI newURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(citaDto.getId()).toUri();
        return ResponseEntity.created(newURI).body(citaDto);
    }

    @Transactional
    public Cita borrarAdjunto(Long idCita, Long idAdjunto, UUID idAutor) {
        Cita cita = findById(idCita);
        AtomicReference<Adjunto> adjunto = new AtomicReference<>(new Adjunto());
        AtomicReference<String> nombreFichero = new AtomicReference<>("");
        if (!cita.getChat().isEmpty()) {
            cita.getChat().forEach(adj -> {
                if (Objects.equals(adj.getId(), idAdjunto)) {
                    if (Objects.equals(adj.getAutor().getId(), idAutor)) {
                        nombreFichero.set(adj.getContenido());
                        adjunto.set(adj);
                    } else {
                        throw new OperacionDenegadaException("No se puede borrar un fichero o mensaje que no pertenezca al usuario");
                    }
                }
            });
            adjunto.get().borrarCita(cita);
            if (adjunto.get().isFichero()) {
                storageService.deleteFile(nombreFichero.get());
            }
        }
        return repository.save(cita);
    }

}
