package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.ClienteRepository;
import com.salesianostriana.dam.talleresruiz.search.spec.cliente.ClienteSpecificationBuilder;
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
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ClienteService {

    private final ClienteRepository repository;
    private final ClienteDtoConverter converter;

    public List<Cliente> findAll() {
        List<Cliente> result = repository.findAll();
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen clientes");
        }
        return result;
    }

    public Page<Cliente> findAll(Specification<Cliente> spec, Pageable pageable) {
        Page<Cliente> result = repository.findAll(spec, pageable);
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen clientes");
        }
        return result;
    }

    public Cliente findById(UUID id) {
        return repository.findById(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public Cliente add(Cliente cliente, User user) {
        cliente.setUsuario(user);
        return repository.save(cliente);
    }

    public boolean existsMatricula(String matricula) {
        return repository.existsByMatricula(matricula);
    }

    public PageDto<ClienteDto> paginarFiltrarClientes(String search, Pageable pageable) {
        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(search);

        ClienteSpecificationBuilder songSpecification = new ClienteSpecificationBuilder(params);
        Specification<Cliente> spec = songSpecification.build();

        Page<ClienteDto> resultDto = this.findAll(spec, pageable).map(converter::of);

        return new PageDto<ClienteDto>(resultDto);
    }

    @Transactional
    public Cliente mostrarClienteConCitas(UUID id) {
        return repository.findByIdCitas(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

}
