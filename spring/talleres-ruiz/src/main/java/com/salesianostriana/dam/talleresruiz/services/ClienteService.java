package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.repositories.ClienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ClienteService {

    private final ClienteRepository repository;

    /*@Transactional
    public List<Cliente> mostrarClientesCitas() {
        // MIRAR EN EL EJEMPLO 10_MULTIPLEBAGFETCHEXCEPTION - CATEGORIA SERVICE
    }*/

}
