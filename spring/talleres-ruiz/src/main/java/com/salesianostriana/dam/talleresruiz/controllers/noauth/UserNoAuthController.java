package com.salesianostriana.dam.talleresruiz.controllers.noauth;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.CrearUser;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;

@Validated
@RestController
@RequestMapping("/noauth/user")
@RequiredArgsConstructor
@Tag(name = "Usuario No Log", description = "Controlador para la gestión de usuarios no logueados")
public class UserNoAuthController {

    private final UserService userService;
    private final ClienteService clienteService;
    private final ClienteDto clienteDto;

    @PostMapping("/register")
    public ResponseEntity<ClienteDto> crearUsuarioCliente(@Valid @RequestBody CrearUser createUser) {
        User user = userService.add(createUser.toUserCliente(createUser));
        ClienteDto newCliente = clienteDto.of(clienteService.add(createUser.toCliente(createUser), user));
        URI newURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newCliente.getId()).toUri();
        return ResponseEntity.created(newURI).body(newCliente);
    }

}
