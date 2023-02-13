package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDtoConverter;
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
import java.util.List;

@Service
@RequiredArgsConstructor
public class CitaService {

    private final CitaRepository repository;
    //private final CitaDtoConverter converter;

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

}
