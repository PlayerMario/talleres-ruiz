package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.salesianostriana.dam.talleresruiz.services.CitaService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/auth/cita")
@RequiredArgsConstructor
@Tag(name = "Cita", description = "Controlador para la gestión de citas")
public class CitaController {

    private final CitaService service;

}
