package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.ClienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ClienteService {

    private final ClienteRepository repository;

    public List<Cliente> findAll() {
        return repository.findAll();
    }

    public Cliente add(Cliente cliente, User user) {
        cliente.setId(user.getId());
        cliente.setUsuario(user);
        return repository.save(cliente);
    }

    public boolean existsMatricula(String matricula) {
        return repository.existsByMatricula(matricula);
    }

    /*@Transactional
    public List<Cliente> mostrarClientesCitas() {
        // MIRAR EN EL EJEMPLO 10_MULTIPLEBAGFETCHEXCEPTION - CATEGORIA SERVICE
    }*/

}
