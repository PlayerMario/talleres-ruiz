package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.CitaNoCancelable;
import com.salesianostriana.dam.talleresruiz.errors.exceptions.MecanicoNoDisponible;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaEditMecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.repositories.CitaRepository;
import com.salesianostriana.dam.talleresruiz.search.spec.cita.CitaSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteriaExtractor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CitaService {

    private final CitaRepository repository;

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
                    cita.setMecanico(mecanico);
                    cita.setFechaHora(edit.getFechaHora());
                    cita.setEstado(edit.getEstado());
                    cita.setServicios(edit.getServicios());
                    return repository.save(cita);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra la cita con ID: " + id));
    }

    public void delete(Long id) {
        if (repository.existsById(id)) {
            Cita cita = this.findById(id);
            if (cita.getEstado().equalsIgnoreCase("Proceso") || cita.getEstado().equalsIgnoreCase("Terminada")) {
                throw new CitaNoCancelable();
            }
            cita.borrarCliente(cita.getCliente());
            repository.delete(cita);
        }
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

        Page<CitaDto> resultDto = this.findAll(spec, pageable).map(CitaDtoConverter::of);

        return new PageDto<CitaDto>(resultDto);
    }

    @Transactional
    public Cita mostrarCitaConChat(Long id) {
        return repository.findByIdChat(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra la cita con ID: " + id));
    }

    public boolean validarFechaHora(LocalDateTime fechaHora) {
        LocalTime horaCita = LocalTime.of(fechaHora.getHour(), fechaHora.getMinute());
        return fechaHora.getDayOfWeek().getValue() != 6
                && fechaHora.getDayOfWeek().getValue() != 7
                && !horaCita.isBefore(LocalTime.of(7, 30))
                && !horaCita.isAfter(LocalTime.of(15, 30));
    }

}
