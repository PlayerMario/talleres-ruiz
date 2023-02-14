package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.security.UserPassword;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserViews;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Validated
@RestController
@RequestMapping("/auth/user")
@RequiredArgsConstructor
@Tag(name = "Usuario", description = "Controlador para la gestión de usuarios")
public class UserController {

    private final UserService service;

    @Operation(summary = "Modificar la contraseña de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Usuario modificado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "username": "mrl26",
                                                    "nombre": "Mario Ruiz López",
                                                    "avatar": "https://robohash.org/mrl26",
                                                    "createdAt": "10/02/2023 00:00:00"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Cuerpo para la modificación aportado inválido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "BAD_REQUEST",
                                                    "message": "La antigua contraseña no coincide con la original",
                                                    "path": "/auth/user/changePsw",
                                                    "statusCode": 400,
                                                    "date": "12/02/2023 12:49:08"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401", description = "Operación no autorizada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "UNAUTHORIZED",
                                                    "message": "Usuario y/o contraseña incorrecta",
                                                    "path": "/error",
                                                    "statusCode": 401,
                                                    "date": "12/02/2023 12:53:44"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403", description = "Operación prohibida, es necesario estar logueado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "JWT expired at 2023-02-12T11:12:49Z...",
                                                    "path": "/auth/user/changePsw",
                                                    "statusCode": 403,
                                                    "date": "12/02/2023 12:12:49"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Usuario no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al usuario,
                                                    "path": "/auth/user/changePsw",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:59:58"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(UserViews.Master.class)
    @PutMapping("/changePsw")
    public UserDto changePsw(@Valid @RequestBody UserPassword userPassword, @AuthenticationPrincipal User usuario) {
        return UserDto.of(service.editPassword(usuario.getId(), userPassword));
    }

    @Operation(summary = "Modificar la contraseña de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Usuario modificado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = UserDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "username": "mrl26",
                                                    "nombre": "Mario Ruiz López",
                                                    "avatar": "https://robohash.org/mrl26",
                                                    "createdAt": "10/02/2023 00:00:00"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Cuerpo para la modificación aportado inválido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "BAD_REQUEST",
                                                    "message": "La antigua contraseña no coincide con la original",
                                                    "path": "/auth/user/changePsw",
                                                    "statusCode": 400,
                                                    "date": "12/02/2023 12:49:08"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401", description = "Operación no autorizada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "UNAUTHORIZED",
                                                    "message": "Usuario y/o contraseña incorrecta",
                                                    "path": "/error",
                                                    "statusCode": 401,
                                                    "date": "12/02/2023 12:53:44"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403", description = "Operación prohibida, es necesario estar logueado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "JWT expired at 2023-02-12T11:12:49Z...",
                                                    "path": "/auth/user/changePsw",
                                                    "statusCode": 403,
                                                    "date": "12/02/2023 12:12:49"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Usuario no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al usuario,
                                                    "path": "/auth/user/changePsw",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:59:58"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(UserViews.Master.class)
    @PutMapping("/avatar")
    public /*UserDto*/void cambiarAvatar(@AuthenticationPrincipal User usuario) {

    }

}
