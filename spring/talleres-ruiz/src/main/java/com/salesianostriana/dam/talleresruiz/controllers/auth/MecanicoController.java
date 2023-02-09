package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.salesianostriana.dam.talleresruiz.services.MecanicoService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/mecanico")
@RequiredArgsConstructor
@Tag(name = "Mecánico", description = "Controlador para la gestión de mecánicos")
public class MecanicoController {

    private final MecanicoService service;

}
