package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteEdit;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
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

import javax.validation.Valid;
import java.util.UUID;

@Validated
@RestController
@RequestMapping("/auth/cliente")
@RequiredArgsConstructor
@Tag(name = "Cliente", description = "Controlador para la gestión de clientes")
public class ClienteController {

    private final ClienteService service;
    private final ClienteDtoConverter converter;


    @Operation(summary = "Obtener listado de clientes")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Listado de clientes encontrado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PageDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "nombre": "Jose Javier Moriña León",
                                                            "username": "jjml4",
                                                            "dni": "52874103V",
                                                            "email": "jj@jj.com",
                                                            "tlf": "675 796 623",
                                                            "avatar": "https://robohash.org/jjml4",
                                                            "vehiculo": "2014GMD-Kia Rio"
                                                        },
                                                        {
                                                            "nombre": "Manuel Delgado Hernández",
                                                            "username": "mdh11",
                                                            "dni": "29556486K",
                                                            "email": "manu@manu.com",
                                                            "tlf": "698 520 147",
                                                            "avatar": "https://robohash.org/mdh11",
                                                            "vehiculo": "8520KMM-Opel Astra"
                                                        },
                                                        {
                                                            "nombre": "Francisco Martín Fernández",
                                                            "username": "fmf14",
                                                            "dni": "60437101Y",
                                                            "email": "fran@fran.com",
                                                            "tlf": "641 785 203",
                                                            "avatar": "https://robohash.org/fmf14",
                                                            "vehiculo": "0214HNM-Kia Ceed"
                                                        },
                                                        {
                                                            "nombre": "Irene Salas Murciano",
                                                            "username": "ism5",
                                                            "dni": "47017557I",
                                                            "email": "irene@irene.com",
                                                            "tlf": "692 014 752",
                                                            "avatar": "https://robohash.org/ism5",
                                                            "vehiculo": "5221SCD-Renault Clio"
                                                        },
                                                        {
                                                            "nombre": "Francisco Martín Fernández",
                                                            "username": "lgm4",
                                                            "dni": "49655052A",
                                                            "email": "fran@fran.com",
                                                            "tlf": "685 027 893",
                                                            "avatar": "https://robohash.org/lgm4",
                                                            "vehiculo": "5877FCD-Seat Ibiza"
                                                        }
                                                    ],
                                                    "totalElements": 8,
                                                    "totalPages": 2,
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
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol del usuario",
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
            @ApiResponse(responseCode = "404", description = "No existen clientes",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No existen clientes",
                                                    "path": "/auth/cliente/",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:20:59"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(ClienteViews.Master.class)
    @GetMapping("/")
    public PageDto<ClienteDto> listarClientes(
            @RequestParam(value = "search", defaultValue = "") String search,
            @PageableDefault(size = 5, page = 0) Pageable pageable) {
        return service.paginarFiltrarClientes(search, pageable);
    }

    @Operation(summary = "Obtener detalles de un cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Clientes encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ClienteDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "nombre": "Jose Javier Moriña León",
                                                    "username": "jjml4",
                                                    "dni": "52874103V",
                                                    "email": "jj@jj.com",
                                                    "tlf": "675 796 623",
                                                    "avatar": "https://robohash.org/jjml4",
                                                    "roles": [
                                                        "CLIENTE"
                                                    ],
                                                    "vehiculo": "2014GMD-Kia Rio",
                                                    "citas": [
                                                        {
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "2023-01-18 12:00",
                                                            "servicios": [
                                                                "Cambio aceite",
                                                                "Cambio filtro aceite"
                                                            ],
                                                            "estado": "Terminado"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "2022-05-18 10:00",
                                                            "servicios": [
                                                                "Cambio neumáticos",
                                                                "Cambio filtro aire",
                                                                "Cambio filtro habitáculo"
                                                            ],
                                                            "estado": "Terminado"
                                                        }
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
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol del usuario",
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
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al cliente con ID: d182a454-9998-4c82-a622-02d7bafc0379",
                                                    "path": "/auth/cliente/d182a454-9998-4c82-a622-2d7bafc0379",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:59:58"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(ClienteViews.DetallesClientes.class)
    @GetMapping("/{id}")
    public ClienteDto mostrarDetallesCliente(@PathVariable UUID id) {
        return converter.of(service.mostrarClienteConCitas(id));
    }

    @Operation(summary = "Obtener detalles de un cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Clientes encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ClienteDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "nombre": "Jose Javier Moriña León",
                                                    "username": "jjml4",
                                                    "dni": "52874103V",
                                                    "email": "jj@jj.com",
                                                    "tlf": "675 796 623",
                                                    "avatar": "https://robohash.org/jjml4",
                                                    "roles": [
                                                        "CLIENTE"
                                                    ],
                                                    "vehiculo": "2014GMD-Kia Rio",
                                                    "citas": [
                                                        {
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "2023-01-18 12:00",
                                                            "servicios": [
                                                                "Cambio aceite",
                                                                "Cambio filtro aceite"
                                                            ],
                                                            "estado": "Terminado"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "2022-05-18 10:00",
                                                            "servicios": [
                                                                "Cambio neumáticos",
                                                                "Cambio filtro aire",
                                                                "Cambio filtro habitáculo"
                                                            ],
                                                            "estado": "Terminado"
                                                        }
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
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al cliente con ID: d182a454-9998-4c82-a622-02d7bafc0379",
                                                    "path": "/auth/cliente/d182a454-9998-4c82-a622-2d7bafc0379",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:59:58"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(ClienteViews.DetallesClientes.class)
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/me")
    public ClienteDto mostrarDetallesMe(@AuthenticationPrincipal User usuario) {
        return converter.of(service.mostrarClienteConCitas(usuario.getId()));
    }

    @Operation(summary = "Obtener citas de un cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Citas encontradas",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PageDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "2023-01-18 12:00",
                                                            "servicios": [
                                                                "Cambio aceite",
                                                                "Cambio filtro aceite"
                                                            ],
                                                            "estado": "Terminado"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "2022-05-18 10:00",
                                                            "servicios": [
                                                                "Cambio neumáticos",
                                                                "Cambio filtro aire",
                                                                "Cambio filtro habitáculo"
                                                            ],
                                                            "estado": "Terminado"
                                                        }
                                                    ],
                                                    "totalElements": 2,
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
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol del usuario",
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
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado o sin citas",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No existen citas del cliente",
                                                    "path": "/auth/cliente/76406075-be67-47f1-9f92-32388c019bb3/citas",
                                                    "statusCode": 404,
                                                    "date": "12/02/2023 19:23:03"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(ClienteViews.DetallesClientes.class)
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/me/citas")
    public PageDto<CitaDto> mostrarCitasCliente(
            @AuthenticationPrincipal User usuario,
            @PageableDefault(size = 5, page = 0) Pageable pageable) {
        return service.citasCliente(usuario.getId(), pageable);
    }

    @Operation(summary = "Modificar un cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Clientes modificado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ClienteDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "nombre": "Bartolomé Méndez Zuluaga",
                                                    "username": "jjml4",
                                                    "dni": "22222222A",
                                                    "email": "bart@bart.com",
                                                    "tlf": "777 888 999",
                                                    "avatar": "https://robohash.org/jjml4",
                                                    "vehiculo": "2036VFH-Ford Mondeo"
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
                                                    "path": "/auth/cliente/d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "statusCode": 400,
                                                    "date": "11/02/2023 20:54:23",
                                                    "subErrors": [
                                                        {
                                                            "object": "clienteEdit",
                                                            "message": "La matrícula ya existe",
                                                            "field": "matricula",
                                                            "rejectedValue": "2036VFH"
                                                        },
                                                        {
                                                            "object": "clienteEdit",
                                                            "message": "El DNI ya existe",
                                                            "field": "dni",
                                                            "rejectedValue": "22222222A"
                                                        }
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
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra al usuario con ID: d182a454-9998-4c82-a622-02d7bafc0379",
                                                    "path": "/auth/cliente/d182a454-9998-4c82-a622-2d7bafc0379",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:59:58"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(ClienteViews.Master.class)
    @PreAuthorize("isAuthenticated()")
    @PutMapping("/me")
    public ClienteDto modificarCliente(@AuthenticationPrincipal User usuario, @Valid @RequestBody ClienteEdit edit) {
        return converter.of(service.edit(usuario.getId(), edit));
    }

    @Operation(summary = "Eliminar un cliente, buscado por su ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Cliente eliminado correctamente, sin contenido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Cliente.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {}
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
    })
    @PreAuthorize("isAuthenticated()")
    @DeleteMapping("/me")
    public ResponseEntity<?> borrarClienteMe(@AuthenticationPrincipal User usuario) {
        service.delete(usuario.getId());
        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Eliminar un cliente, buscado por su ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Cliente eliminado correctamente, sin contenido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Cliente.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {}
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
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> borrarCliente(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

}
