package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDto;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteEdit;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
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
                                                            "vehiculo": "2014GMD-Fiat Punto"
                                                        }
                                                    ],
                                                    "totalElements": 1,
                                                    "totalPages": 1,
                                                    "number": 0,
                                                    "size": 5
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
                            array = @ArraySchema(schema = @Schema(implementation = ClienteDto.class)),
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
    @JsonView(ClienteViews.MostrarDetalles.class)
    @GetMapping("/{id}")
    public ClienteDto mostrarDetallesCliente(@PathVariable UUID id) {
        return converter.of(service.mostrarClienteConCitas(id));
    }

    @Operation(summary = "Modificar un cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Clientes modificado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = ClienteDto.class)),
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
    @PutMapping("/{id}")
    public ClienteDto modificarCliente(@PathVariable UUID id, @Valid @RequestBody ClienteEdit edit) {
        return converter.of(service.edit(id, edit));
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
                    )})})
    @DeleteMapping("/{id}")
    public ResponseEntity<?> borrarCliente(@PathVariable UUID id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

}
