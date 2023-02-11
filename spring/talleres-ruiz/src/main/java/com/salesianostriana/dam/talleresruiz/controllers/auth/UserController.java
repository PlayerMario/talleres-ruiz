package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/auth/user")
@RequiredArgsConstructor
@Tag(name = "Usuario", description = "Controlador para la gestión de usuarios")
public class UserController {

    private final UserService service;

}
