package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.ClienteNoDisponible;
import com.salesianostriana.dam.talleresruiz.errors.exceptions.MecanicoNoDisponible;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteEdit;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.CitaRepository;
import com.salesianostriana.dam.talleresruiz.repositories.ClienteRepository;
import com.salesianostriana.dam.talleresruiz.search.spec.cliente.ClienteSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ClienteService {

    private final ClienteRepository repository;
    private final UserService userService;
    private final ClienteDtoConverter converter;
    private final CitaRepository citaRepository;

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
                new EntityNotFoundException("No se encuentra al cliente con ID: " + id));
    }

    public Cliente add(Cliente cliente, User user) {
        cliente.setUsuario(user);
        return repository.save(cliente);
    }

    public Cliente edit(UUID id, ClienteEdit edit) {
        return repository.findById(id)
                .map(cliente -> {
                    cliente.setUsuario(userService.editUser(cliente.getId(), edit));
                    cliente.setVehiculo(edit.getVehiculo());
                    cliente.setMatricula(edit.getMatricula());
                    return repository.save(cliente);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al cliente con ID: " + id));
    }

    public void delete(UUID id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);
        }
    }

    public boolean existsMatricula(String matricula) {
        return repository.existsByMatricula(matricula);
    }

    public PageDto<ClienteDto> paginarFiltrarClientes(String search, Pageable pageable) {
        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(search);

        ClienteSpecificationBuilder clienteSpecification = new ClienteSpecificationBuilder(params);
        Specification<Cliente> spec = clienteSpecification.build();

        Page<ClienteDto> resultDto = this.findAll(spec, pageable).map(converter::of);

        return new PageDto<ClienteDto>(resultDto);
    }

    @Transactional
    public Cliente mostrarClienteConCitas(UUID id) {
        return repository.findByIdCitas(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public PageDto<CitaDto> citasCliente(UUID id, Pageable pageable) {
        List<CitaDto> citas = this.findById(id).getCitas()
                .stream().map(CitaDtoConverter::toClienteDetalles).toList();
        if (citas.isEmpty()) {
            throw new EntityNotFoundException("No existen citas del cliente");
        }
        Page<CitaDto> resultDto = new PageImpl<>(citas, pageable, citas.size());
        return new PageDto<CitaDto>(resultDto);
    }

    public void comprobarDisponibilidad(UUID idUs, LocalDateTime fechaHora) {
        List<Cita> citas = citaRepository.findDistinctByClienteAndFechaHora(this.findById(idUs), fechaHora);
        if (!citas.isEmpty()) {
            throw new ClienteNoDisponible();
        }
    }

    public void comprobarDisponibilidadModif(UUID idUs, Long idCita, LocalDateTime fechaHora) {
        List<Cita> citas = citaRepository.findDistinctByClienteAndFechaHora(this.findById(idUs), fechaHora);
        if (!citas.isEmpty()) {
            citas.forEach(cita -> {
                if (!Objects.equals(cita.getId(), idCita)) {
                    throw new ClienteNoDisponible();
                }
            });
        }
    }
}
