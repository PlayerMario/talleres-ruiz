package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.MecanicoNoDisponible;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoDto;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserEdit;
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
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MecanicoService {

    private final MecanicoRepository repository;
    private final MecanicoDtoConverter converter;
    private final UserService userService;
    private final CitaService citaService;
    private final CitaRepository citaRepository;
    private final MensajeService mensajeService;

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
            citaService.setearNullMecanico(mec);
            mensajeService.setearNullAutor(mec.getUsuario());
            repository.deleteById(id);
        }
    }

    public PageDto<MecanicoDto> paginarFiltrarMecanicos(String search, Pageable pageable) {
        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(search);

        MecanicoSpecificationBuilder mecanicoSpecification = new MecanicoSpecificationBuilder(params);
        Specification<Mecanico> spec = mecanicoSpecification.build();

        Page<MecanicoDto> resultDto = this.findAll(spec, pageable).map(converter::of);

        return new PageDto<MecanicoDto>(resultDto);
    }

    public void comprobarDisponibilidad(UUID id, LocalDateTime fechaHora) {
        List<Cita> citas = citaRepository.findDistinctByMecanicoAndFechaHora(this.findById(id), fechaHora);
        if (!citas.isEmpty()) {
            throw new MecanicoNoDisponible();
        }
    }

}
