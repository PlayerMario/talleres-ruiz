package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
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
import org.springframework.data.domain.Sort;
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
                                                            "id": "d182a454-9998-4c82-a622-2d7bafc0379a",
                                                            "nombre": "Jose Javier Moriña León",
                                                            "username": "cliente",
                                                            "dni": "52874103V",
                                                            "email": "jj@jj.com",
                                                            "tlf": "675 796 623",
                                                            "avatar": "cliente.png",
                                                            "vehiculo": "2014GMD-Kia Rio"
                                                        },
                                                        {
                                                            "id": "c2cac01b-0bc0-4748-ab28-956190e4ab7a",
                                                            "nombre": "Manuel Delgado Hernández",
                                                            "username": "mdh11",
                                                            "dni": "29556486K",
                                                            "email": "manu@manu.com",
                                                            "tlf": "698 520 147",
                                                            "avatar": "mdh11.png",
                                                            "vehiculo": "8520KMM-Opel Astra"
                                                        },
                                                        {
                                                            "id": "bc2a6f6e-b4b9-40d1-ab90-fe9d78ae414e",
                                                            "nombre": "Francisco Martín Fernández",
                                                            "username": "fmf14",
                                                            "dni": "60437101Y",
                                                            "email": "fran@fran.com",
                                                            "tlf": "641 785 203",
                                                            "avatar": "fmf14.png",
                                                            "vehiculo": "0214HNM-Kia Ceed"
                                                        },
                                                        {
                                                            "id": "1240bad9-5055-43ca-a640-75cd1f59c493",
                                                            "nombre": "Irene Salas Murciano",
                                                            "username": "ism5",
                                                            "dni": "47017557I",
                                                            "email": "irene@irene.com",
                                                            "tlf": "692 014 752",
                                                            "avatar": "ism5.png",
                                                            "vehiculo": "5221SCD-Renault Clio"
                                                        },
                                                        {
                                                            "id": "72b1385c-4a6f-4a43-9539-d04c154c7b71",
                                                            "nombre": "Laura Gordillo Moreno",
                                                            "username": "lgm4",
                                                            "dni": "49655052A",
                                                            "email": "laura@laura.com",
                                                            "tlf": "685 027 893",
                                                            "avatar": "lgm4.png",
                                                            "vehiculo": "5877FCD-Seat Ibiza"
                                                        }
                                                    ],
                                                    "totalElements": 9,
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
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "Access is denied",
                                                    "path": "/auth/cliente/",
                                                    "statusCode": 403,
                                                    "date": "15/02/2023 19:36:09"
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
            @ApiResponse(responseCode = "200", description = "Cliente encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ClienteDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "nombre": "Jose Javier Moriña León",
                                                    "username": "cliente",
                                                    "dni": "52874103V",
                                                    "email": "jj@jj.com",
                                                    "tlf": "675 796 623",
                                                    "avatar": "cliente.png",
                                                    "roles": [
                                                        "CLIENTE"
                                                    ],
                                                    "vehiculo": "2014GMD-Kia Rio",
                                                    "citas": [
                                                        {
                                                            "id": 1,
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "18-01-2023 12:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "id": 4,
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "18-05-2022 10:00",
                                                            "estado": "Terminada"
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
                                                    "path": "/auth/cliente/d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "statusCode": 403,
                                                    "date": "15/02/2023 19:39:36"
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
        return service.generarClienteDto(service.mostrarClienteConCitas(id));
    }

    @Operation(summary = "Obtener detalles del cliente logueado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Detalles encontrados",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ClienteDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "nombre": "Jose Javier Moriña León",
                                                    "username": "cliente",
                                                    "dni": "52874103V",
                                                    "email": "jj@jj.com",
                                                    "tlf": "675 796 623",
                                                    "avatar": "cliente.png",
                                                    "roles": [
                                                        "CLIENTE"
                                                    ],
                                                    "vehiculo": "2014GMD-Kia Rio",
                                                    "citas": [
                                                        {
                                                            "id": 1,
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "18-01-2023 12:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "id": 4,
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "18-05-2022 10:00",
                                                            "estado": "Terminada"
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
                    )})
    })
    @JsonView(ClienteViews.DetallesClientes.class)
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/me")
    public ClienteDto mostrarDetallesMe(@AuthenticationPrincipal User usuario) {
        return service.generarClienteDto(service.mostrarClienteConCitas(usuario.getId()));
    }

    @Operation(summary = "Obtener citas de un cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Citas del cliente encontradas",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PageDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "id": 1,
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "18-01-2023 12:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "id": 4,
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "18-05-2022 10:00",
                                                            "estado": "Terminada"
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
            @ApiResponse(responseCode = "403", description = "Acceso prohibido por rol",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "Access is denied",
                                                    "path": "/auth/cliente/me/citas",
                                                    "statusCode": 403,
                                                    "date": "15/02/2023 19:40:59"
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
            @PageableDefault(size = 5, page = 0, sort = "fechaHora", direction = Sort.Direction.DESC) Pageable pageable) {
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
                                                    "id": "d182a454-9998-4c82-a622-2d7bafc0379a",
                                                    "nombre": "Bartolomé Méndez Zuluaga",
                                                    "username": "cliente",
                                                    "dni": "52874103V",
                                                    "email": "bart@bart.com",
                                                    "tlf": "777 888 999",
                                                    "avatar": "cliente.png",
                                                    "roles": [
                                                        "CLIENTE"
                                                    ],
                                                    "vehiculo": "2036VFH-Ford Mondeo",
                                                    "citas": [
                                                        {
                                                            "id": 1,
                                                            "mecanico": "Mario Ruiz López",
                                                            "fechaHora": "18-01-2023 12:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "id": 4,
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "fechaHora": "18-05-2022 10:00",
                                                            "estado": "Terminada"
                                                        }
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
                                                    "path": "/auth/cliente/me",
                                                    "statusCode": 400,
                                                    "date": "20/02/2023 16:05:11",
                                                    "subErrors": [
                                                        {
                                                            "object": "clienteEdit",
                                                            "message": "El email no puede estar vacío",
                                                            "field": "email",
                                                            "rejectedValue": ""
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
                                                    "date": "15/02/2023 19:42:32"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(ClienteViews.DetallesClientes.class)
    @PreAuthorize("isAuthenticated()")
    @PutMapping("/me")
    public ClienteDto modificarCliente(@AuthenticationPrincipal User usuario, @Valid @RequestBody ClienteEdit edit) {
        return service.generarClienteDto(service.edit(usuario.getId(), edit));
    }

    @Operation(summary = "Eliminar el cliente logueado")
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
                                                    "date": "15/02/2023 19:42:58"
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
                                                    "path": "/auth/cliente/d182a454-9998-4c82-a622-2d7bafc0379a",
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
