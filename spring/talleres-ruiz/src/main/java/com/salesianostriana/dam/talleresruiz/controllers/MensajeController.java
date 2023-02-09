package com.salesianostriana.dam.talleresruiz.controllers;

import com.salesianostriana.dam.talleresruiz.services.MensajeService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/mensaje")
@RequiredArgsConstructor
@Tag(name = "Mensaje", description = "Controlador para la gestión de mensajes")
public class MensajeController {

    private final MensajeService service;

}
