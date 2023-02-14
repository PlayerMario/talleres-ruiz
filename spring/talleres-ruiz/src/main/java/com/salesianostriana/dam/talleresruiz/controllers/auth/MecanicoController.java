package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.*;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserCreate;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserEdit;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.services.MecanicoService;
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
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;
import java.util.UUID;

@Validated
@RestController
@RequestMapping("/auth/mecanico")
@RequiredArgsConstructor
@Tag(name = "Mecánico", description = "Controlador para la gestión de mecánicos")
public class MecanicoController {

    private final MecanicoService service;
    private final MecanicoDtoConverter converter;
    private final UserService userService;


    @Operation(summary = "Obtener listado de mecánicos")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Listado de mecánicos encontrado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = MecanicoDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "nombre": "Alejandro Santos Pacheco",
                                                            "username": "asp14",
                                                            "dni": "30376644T",
                                                            "email": "ale@ale.com",
                                                            "tlf": "675 796 623",
                                                            "avatar": "https://robohash.org/asp14"
                                                        },
                                                        {
                                                            "nombre": "Mario Ruiz López",
                                                            "username": "mrl26",
                                                            "dni": "09124790Y",
                                                            "email": "mario@mario.com",
                                                            "tlf": "676 384 054",
                                                            "avatar": "https://robohash.org/mrl26"
                                                        },
                                                        {
                                                            "nombre": "Luis Verde Cantero",
                                                            "username": "lvc19",
                                                            "dni": "84731084D",
                                                            "email": "luis@luis.com",
                                                            "tlf": "620 485 963",
                                                            "avatar": "https://robohash.org/lvc19"
                                                        }
                                                    ],
                                                    "totalElements": 3,
                                                    "totalPages": 1,
                                                    "number": 0,
                                                    "size": 5
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401", description = "Debe loguearse para poder acceder",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "UNAUTHORIZED",
                                                    "message": "Usuario y/o contraseña incorrecta",
                                                    "path": "/error",
                                                    "statusCode": 401,
                                                    "date": "14/02/2023 08:48:53"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "Access is denied",
                                                    "path": "/auth/cliente/me",
                                                    "statusCode": 403,
                                                    "date": "14/02/2023 09:00:35"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "No existen mecánicos",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No existen mecánicos",
                                                    "path": "/auth/mecanico/",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:20:59"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(MecanicoViews.Master.class)
    @GetMapping("/")
    public PageDto<MecanicoDto> listarMecanicos(
            @RequestParam(value = "search", defaultValue = "") String search,
            @PageableDefault(size = 5, page = 0) Pageable pageable) {
        return service.paginarFiltrarMecanicos(search, pageable);
    }

    @Operation(summary = "Obtener detalles de un mecánico")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Mecánico encontrado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = MecanicoDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "nombre": "Mario Ruiz López",
                                                    "username": "mrl26",
                                                    "dni": "09124790Y",
                                                    "email": "mario@mario.com",
                                                    "tlf": "676 384 054",
                                                    "avatar": "https://robohash.org/mrl26",
                                                    "roles": [
                                                        "ADMIN",
                                                        "MEC"
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401", description = "Debe loguearse para poder acceder",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "UNAUTHORIZED",
                                                    "message": "Usuario y/o contraseña incorrecta",
                                                    "path": "/error",
                                                    "statusCode": 401,
                                                    "date": "14/02/2023 08:48:53"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "Access is denied",
                                                    "path": "/auth/cliente/me",
                                                    "statusCode": 403,
                                                    "date": "14/02/2023 09:00:35"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Mecánico no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al mecánico con ID: 3e380d54-861c-4809-bb84-0bd32bab42c2",
                                                    "path": "/auth/mecanico/3e380d54-861c-4809-bb84-bd32bab42c2",
                                                    "statusCode": 404,
                                                    "date": "12/02/2023 17:04:37"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(MecanicoViews.DetallesMecanicos.class)
    @GetMapping("/{id}")
    public MecanicoDto mostrarDetallesMecanico(@PathVariable UUID id) {
        return converter.of(service.findById(id));
    }

    @Operation(summary = "Obtener detalles de un mecánico")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Mecánico encontrado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = MecanicoDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "nombre": "Mario Ruiz López",
                                                    "username": "mrl26",
                                                    "dni": "09124790Y",
                                                    "email": "mario@mario.com",
                                                    "tlf": "676 384 054",
                                                    "avatar": "https://robohash.org/mrl26",
                                                    "roles": [
                                                        "ADMIN",
                                                        "MEC"
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401", description = "Debe loguearse para poder acceder",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "UNAUTHORIZED",
                                                    "message": "Usuario y/o contraseña incorrecta",
                                                    "path": "/error",
                                                    "statusCode": 401,
                                                    "date": "14/02/2023 08:48:53"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "Access is denied",
                                                    "path": "/auth/cliente/me",
                                                    "statusCode": 403,
                                                    "date": "14/02/2023 09:00:35"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Mecánico no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al mecánico con ID: 3e380d54-861c-4809-bb84-0bd32bab42c2",
                                                    "path": "/auth/mecanico/3e380d54-861c-4809-bb84-bd32bab42c2",
                                                    "statusCode": 404,
                                                    "date": "12/02/2023 17:04:37"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(MecanicoViews.DetallesMecanicos.class)
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/me")
    public MecanicoDto mostrarDetallesMecanicoMe(@AuthenticationPrincipal User usuario) {
        return converter.of(service.findById(usuario.getId()));
    }


    @Operation(summary = "Crear nuevo usuario mecánico administrador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Administrador creado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = MecanicoDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "c0a80180-8646-17f3-8186-46888f6d0000",
                                                    "nombre": "Francisco Javier Quirón Martín",
                                                    "username": "fjqm23",
                                                    "dni": "65852014C",
                                                    "email": "javi@javi.com",
                                                    "tlf": "690 975 563",
                                                    "avatar": "https://robohash.org/fjqm23",
                                                    "roles": [
                                                        "ADMIN",
                                                        "MEC"
                                                    ]
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
                                                    "path": "/auth/mecanico/admin",
                                                    "statusCode": 400,
                                                    "date": "12/02/2023 17:50:08",
                                                    "subErrors": [
                                                        {
                                                            "object": "mecanicoCreate",
                                                            "message": "El teléfono ya existe",
                                                            "field": "tlf",
                                                            "rejectedValue": "690 975 563"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(MecanicoViews.DetallesMecanicos.class)
    @PostMapping("/admin")
    ResponseEntity<MecanicoDto> crearUsuarioMecAdmin(@Valid @RequestBody UserCreate createMecanico) {
        User user = userService.add(createMecanico.toUserAdminMec(createMecanico, 1));
        Mecanico mec = new Mecanico();
        MecanicoDto newMecanico = converter.of(service.add(mec, user));
        URI newURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newMecanico.getId()).toUri();
        return ResponseEntity.created(newURI).body(newMecanico);
    }

    @Operation(summary = "Crear nuevo usuario mecánico")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Mecánico creado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = MecanicoDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "c0a80180-8646-146a-8186-4684c9f50000",
                                                    "nombre": "Ismael Collado Bernal",
                                                    "username": "icb9",
                                                    "dni": "36520148V",
                                                    "email": "isma@isma.com",
                                                    "tlf": "643 980 764",
                                                    "avatar": "https://robohash.org/icb9",
                                                    "roles": [
                                                        "MEC"
                                                    ]
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
                                                    "path": "/auth/mecanico/mec",
                                                    "statusCode": 400,
                                                    "date": "12/02/2023 17:46:00",
                                                    "subErrors": [
                                                        {
                                                            "object": "mecanicoCreate",
                                                            "message": "El email ya existe",
                                                            "field": "email",
                                                            "rejectedValue": "isma@isma.com"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(MecanicoViews.DetallesMecanicos.class)
    @PostMapping("/mec")
    ResponseEntity<MecanicoDto> crearUsuarioMec(@Valid @RequestBody UserCreate createMecanico) {
        User user = userService.add(createMecanico.toUserAdminMec(createMecanico, 2));
        Mecanico mec = new Mecanico();
        MecanicoDto newMecanico = converter.of(service.add(mec, user));
        URI newURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newMecanico.getId()).toUri();
        return ResponseEntity.created(newURI).body(newMecanico);
    }

    @Operation(summary = "Modificar un mecánico")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Mecánico modificado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = MecanicoDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "nombre": "Bartolomé Méndez Zuluaga",
                                                    "username": "mrl26",
                                                    "dni": "09124790Y",
                                                    "email": "bart@bart.com",
                                                    "tlf": "777 888 999",
                                                    "avatar": "https://robohash.org/mrl26",
                                                    "roles": [
                                                        "ADMIN",
                                                        "MEC"
                                                    ]
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
                                                    "message": "Error en la validación, compruebe la lista",
                                                    "path": "/auth/mecanico/3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "statusCode": 400,
                                                    "date": "12/02/2023 18:22:42",
                                                    "subErrors": [
                                                        {
                                                            "object": "userEdit",
                                                            "message": "El teléfono ya existe",
                                                            "field": "tlf",
                                                            "rejectedValue": "777 888 999"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Mecánico no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al mecánico con ID: 3e380d54-861c-4809-bb84-0bd32bab42c2",
                                                    "path": "/auth/mecanico/3e380d54-861c-4809-bb84-bd32bab42c2",
                                                    "statusCode": 404,
                                                    "date": "12/02/2023 18:23:30"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(MecanicoViews.DetallesMecanicos.class)
    @PutMapping("/{id}")
    public MecanicoDto modificarMecanico(@PathVariable UUID id, @Valid @RequestBody UserEdit edit) {
        return converter.of(service.edit(id, edit));
    }

    @Operation(summary = "Eliminar un mecánico, buscado por su ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Mecánico eliminado correctamente, sin contenido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Mecanico.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {}
                                            """
                            )}
                    )})})
    @DeleteMapping("/{id}")
    public ResponseEntity<?> borrarMecanico(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

}
