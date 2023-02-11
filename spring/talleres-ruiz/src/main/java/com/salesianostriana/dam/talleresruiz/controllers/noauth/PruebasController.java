package com.salesianostriana.dam.talleresruiz.controllers.noauth;

import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.user.pruebas.UserPruebas;
import com.salesianostriana.dam.talleresruiz.models.dto.user.pruebas.UserPruebasConverter;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/prueba")
@RequiredArgsConstructor
public class PruebasController {

    private final UserService userService;
    private final ClienteService clienteService;
    private final UserPruebasConverter userDto;
    private final ClienteDtoConverter clienteDto;

    @GetMapping("/user")
    public List<UserPruebas> mostrarUsuarios() {
        return userService.findAll().stream().map(userDto::of).toList();
    }

    @GetMapping("/cliente")
    public List<ClienteDto> mostrarClientes() {
        return clienteService.findAll().stream().map(clienteDto::of).toList();
    }

}
