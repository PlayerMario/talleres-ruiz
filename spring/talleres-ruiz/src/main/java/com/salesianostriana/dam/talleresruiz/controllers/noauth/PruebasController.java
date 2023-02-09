package com.salesianostriana.dam.talleresruiz.controllers.noauth;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.ClienteRepository;
import com.salesianostriana.dam.talleresruiz.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/prueba")
@RequiredArgsConstructor
public class PruebasController {

    private final UserRepository userRepository;
    private final ClienteRepository clienteRepository;

    @GetMapping("/user")
    public List<User> mostrarUsuarios() {
        return userRepository.findAll();
    }

    @GetMapping("/cliente")
    public List<Cliente> mostrarClientes() {
        return clienteRepository.findAll();
    }

}
