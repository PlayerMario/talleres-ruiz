package com.salesianostriana.dam.talleresruiz.controllers.noauth;

import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.user.CrearUser;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserLogin;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserToken;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.security.jwtoken.access.JwtProvider;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
    private final ClienteDtoConverter clienteDto;
    private final AuthenticationManager authManager;
    private final JwtProvider tokenProvider;


    @Operation(summary = "Crear nuevo usuario cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Cliente creado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ClienteDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "c0a80180-8640-1a2e-8186-400a3b860000",
                                                    "nombre": "Mario Ruiz",
                                                    "username": "playermario",
                                                    "dni": "11111111A",
                                                    "email": "m@m.com",
                                                    "tlf": "111 222 333",
                                                    "avatar": "https://robohash.org/playermario",
                                                    "roles": [
                                                        "CLIENTE"
                                                    ],
                                                    "vehiculo": "1111AAA-Ford Fiesta"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Cuerpo para la creación aportado inválido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "BAD_REQUEST",
                                                    "message": "Error en la validación, compruebe la lista",
                                                    "path": "/noauth/user/register",
                                                    "statusCode": 400,
                                                    "date": "11/02/2023 11:47:52",
                                                    "subErrors": [
                                                        {
                                                            "object": "crearUser",
                                                            "message": "La matrícula ya existe",
                                                            "field": "matricula",
                                                            "rejectedValue": "2014GMD"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )})
    })
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


    @Operation(summary = "Loguearse como usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Usuario logueado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserToken.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "username": "mrl26",
                                                    "avatar": "https://robohash.org/mrl26",
                                                    "nombre": "Mario Ruiz López",
                                                    "createdAt": "10/02/2023 00:00:00",
                                                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzZTM4MGQ1N
                                                    C04NjFjLTQ4MDktYmI4NC1iZDMyYmFiNDJjMmUiLCJpYXQiOjE2NzYxMTg5NjIsImV4c
                                                    CI6MTY3NjExOTAyMn0.l9NXClujUbApqcG-MklktdYdVL6KAvPq2IiSovoAPsgvrrfb1
                                                    cwVDRnbqLYyH8fP373X7JgW-w_BUeJVgTwpCg"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Cuerpo para la creación aportado inválido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "BAD_REQUEST",
                                                    "message": "Error en la validación, compruebe la lista",
                                                    "path": "/noauth/user/login",
                                                    "statusCode": 400,
                                                    "date": "11/02/2023 13:37:23",
                                                    "subErrors": [
                                                        {
                                                            "object": "userLogin",
                                                            "message": "El nombre de usuario no puede estar vacío",
                                                            "field": "username",
                                                            "rejectedValue": ""
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401", description = "Error en login",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "UNAUTHORIZED",
                                                    "message": "Usuario y/o contraseña incorrecta",
                                                    "path": "/noauth/user/login",
                                                    "statusCode": 401,
                                                    "date": "11/02/2023 13:48:45"
                                                }
                                            """
                            )}
                    )})
    })
    @PostMapping("/login")
    public ResponseEntity<UserToken> login(@Valid @RequestBody UserLogin userLogin) {
        Authentication auth = authManager.authenticate(new UsernamePasswordAuthenticationToken(
                userLogin.getUsername(), userLogin.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(auth);
        String token = tokenProvider.generateToken(auth);
        User user = (User) auth.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED).body(UserToken.of(user, token));

    }

}
