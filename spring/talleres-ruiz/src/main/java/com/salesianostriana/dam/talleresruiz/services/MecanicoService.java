package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.OperacionDenegadaException;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoDto;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserCreate;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserEdit;
import com.salesianostriana.dam.talleresruiz.models.user.Roles;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.CitaRepository;
import com.salesianostriana.dam.talleresruiz.repositories.MecanicoRepository;
import com.salesianostriana.dam.talleresruiz.search.spec.mecanico.MecanicoSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.persistence.EntityNotFoundException;
import java.net.URI;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MecanicoService {

    private final MecanicoRepository repository;
    private final UserService userService;
    private final CitaService citaService;
    private final CitaRepository citaRepository;
    private final AdjuntoService mensajeService;

    public List<Mecanico> findAll() {
        List<Mecanico> result = repository.findAll();
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen mecánicos");
        }
        return result;
    }

    public Page<Mecanico> findAll(Specification<Mecanico> spec, Pageable pageable) {
        Page<Mecanico> result = repository.findAll(spec, pageable);
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen mecánicos");
        }
        return result;
    }

    public Mecanico findById(UUID id) {
        return repository.findById(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al mecánico con ID: " + id));
    }

    public Mecanico add(Mecanico mecanico, User user) {
        mecanico.setUsuario(user);
        return repository.save(mecanico);
    }

    public Mecanico edit(UUID id, UserEdit edit) {
        return repository.findById(id)
                .map(mecanico -> {
                    mecanico.setUsuario(userService.editUser(mecanico.getId(), edit));
                    return repository.save(mecanico);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al mecánico con ID: " + id));
    }

    public void delete(UUID id) {
        if (repository.existsById(id)) {
            Mecanico mec = this.findById(id);
            if (!mec.getUsuario().getRoles().contains(Roles.ADMIN)) {
                citaService.setearNullMecanico(mec);
                mensajeService.setearNullAutor(mec.getUsuario());
                repository.deleteById(id);
            } else {
                throw new OperacionDenegadaException("No se puede puede borrar un admin");
            }
        }
    }

    public PageDto<MecanicoDto> paginarFiltrarMecanicos(String search, Pageable pageable) {
        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(search);
        MecanicoSpecificationBuilder mecanicoSpecification = new MecanicoSpecificationBuilder(params);
        Specification<Mecanico> spec = mecanicoSpecification.build();
        Page<MecanicoDto> resultDto = this.findAll(spec, pageable).map(this::generarMecanicoDto);
        return new PageDto<MecanicoDto>(resultDto);
    }

    public void comprobarDisponibilidad(UUID id, LocalDateTime fechaHora) {
        List<Cita> citas = citaRepository.findDistinctByMecanicoAndFechaHora(this.findById(id), fechaHora);
        if (!citas.isEmpty()) {
            throw new OperacionDenegadaException("El mecánico asignado tiene ocupada ese día y hora");
        }
    }

    public void comprobarDisponibilidadModif(UUID idUs, Long idCita, LocalDateTime fechaHora) {
        List<Cita> citas = citaRepository.findDistinctByMecanicoAndFechaHora(this.findById(idUs), fechaHora);
        if (!citas.isEmpty()) {
            citas.forEach(cita -> {
                if (!Objects.equals(cita.getId(), idCita)) {
                    throw new OperacionDenegadaException("Ya tiene una cita asignada para el día y hora elegido");
                }
            });
        }
    }

    public MecanicoDto generarMecanicoDto(Mecanico mecanico) {
        List<String> roles = new ArrayList<>();

        mecanico.getUsuario().getRoles().forEach(rol -> {
            roles.add(rol.name());
        });
        MecanicoDto mecanicoDto = repository.generarMecanicoDto(mecanico.getId());
        mecanicoDto.setRoles(roles);
        return mecanicoDto;
    }

    public ResponseEntity<MecanicoDto> crearMecanico(UserCreate create, int opcion) {
        User user = userService.add(create.toUserAdminMec(create, opcion));
        Mecanico mec = new Mecanico();
        MecanicoDto newMecanico = generarMecanicoDto(add(mec, user));
        URI newURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newMecanico.getId()).toUri();
        return ResponseEntity.created(newURI).body(newMecanico);
    }

}
