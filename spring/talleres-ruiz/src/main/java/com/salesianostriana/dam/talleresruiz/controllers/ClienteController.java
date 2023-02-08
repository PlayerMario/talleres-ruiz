package com.salesianostriana.dam.talleresruiz.controllers;

import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/cliente")
@RequiredArgsConstructor
@Tag(name = "Cliente", description = "Controlador para la gestión de clientes")
public class ClienteController {

    private final ClienteService service;

}
