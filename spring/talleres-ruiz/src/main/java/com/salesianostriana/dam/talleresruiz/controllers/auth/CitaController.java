package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.*;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoDto;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.services.CitaService;
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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;
import java.util.UUID;

@Validated
@RestController
@RequestMapping("/auth/cita")
@RequiredArgsConstructor
@Tag(name = "Cita", description = "Controlador para la gestión de citas")
public class CitaController {

    private final CitaService service;
    private final MecanicoService mecanicoService;
    private final CitaConverter citaCreateMecanicoConverter;
    private final UserService userService;


    @Operation(summary = "Obtener listado de citas")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Listado de citas encontrado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CitaDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "mecanico": "Mario Ruiz López",
                                                            "cliente": "Jose Javier Moriña León",
                                                            "vehiculo": "Kia Rio-2014GMD",
                                                            "fechaHora": "2023-01-18 12:00",
                                                            "estado": "Terminado"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "cliente": "Jose Javier Moriña León",
                                                            "vehiculo": "Kia Rio-2014GMD",
                                                            "fechaHora": "2022-05-18 10:00",
                                                            "estado": "Terminado"
                                                        },
                                                        {
                                                            "mecanico": "Luis Verde Cantero",
                                                            "cliente": "Manuel Delgado Hernández",
                                                            "vehiculo": "Opel Astra-8520KMM",
                                                            "fechaHora": "2023-03-02 12:00",
                                                            "estado": "Aceptado"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "cliente": "Manuel Delgado Hernández",
                                                            "vehiculo": "Opel Astra-8520KMM",
                                                            "fechaHora": "2022-11-08 11:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "mecanico": "Mario Ruiz López",
                                                            "cliente": "Manuel Delgado Hernández",
                                                            "vehiculo": "Opel Astra-8520KMM",
                                                            "fechaHora": "2022-01-17 16:00",
                                                            "estado": "Terminado"
                                                        }
                                                    ],
                                                    "totalElements": 12,
                                                    "totalPages": 3,
                                                    "number": 0,
                                                    "size": 5
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "No existen citas",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No existen citas",
                                                    "path": "/auth/cita/",
                                                    "statusCode": 404,
                                                    "date": "11/02/2023 14:20:59"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.Master.class)
    @GetMapping("/")
    public PageDto<CitaDto> listarCitas(
            @RequestParam(value = "search", defaultValue = "") String search,
            @PageableDefault(size = 5, page = 0) Pageable pageable) {
        return service.paginarFiltrarCitas(search, pageable);
    }

    @Operation(summary = "Obtener detalles de una cita")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Cita encontrada",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CitaDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": 1,
                                                    "mecanico": "Mario Ruiz López",
                                                    "cliente": "Jose Javier Moriña León",
                                                    "vehiculo": "Kia Rio-2014GMD",
                                                    "fechaHora": "18-01-2023 12:00",
                                                    "servicios": [
                                                        "Cambio aceite",
                                                        "Cambio filtro aceite"
                                                    ],
                                                    "estado": "Terminado",
                                                    "imgVehiculo": [],
                                                    "chat": [
                                                        {
                                                            "autor": "Mario Ruiz López",
                                                            "fechaHora": "18-01-2023 02:10",
                                                            "mensaje": "Hola buenas, hemos visto que también necesitaría un cambio de pastillas de freno."
                                                        },
                                                        {
                                                            "autor": "Jose Javier Moriña León",
                                                            "fechaHora": "18-01-2023 02:30",
                                                            "mensaje": "Hola, en principio no se lo cambiéis, esperaré a más adelante."
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Cita no encontrada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra la cita con ID: 100",
                                                    "path": "/auth/cita/100",
                                                    "statusCode": 404,
                                                    "date": "13/02/2023 09:53:23"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.DetallesCita.class)
    @GetMapping("/{id}")
    public CitaDto mostrarDetallesCita(@PathVariable Long id) {
        return CitaDtoConverter.ofDetails(service.mostrarCitaConChat(id));
    }

    @Operation(summary = "Crear nueva cita")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Cita creada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = CitaDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "mecanico": "Mario Ruiz López",
                                                    "cliente": "Manuel Delgado Hernández",
                                                    "vehiculo": "Opel Astra-8520KMM",
                                                    "fechaHora": "13-02-2023 15:00",
                                                    "estado": "Aceptada"
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
                                                    "path": "/auth/cita/3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "statusCode": 400,
                                                    "date": "13/02/2023 12:51:39",
                                                    "subErrors": [
                                                        {
                                                            "object": "citaCreateMecanico",
                                                            "message": "No se encuentra el nombre de usuario",
                                                            "field": "usernameCliente",
                                                            "rejectedValue": "mdh111"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.Master.class)
    @PostMapping("/mecanico/{id}")
    public ResponseEntity<CitaDto> crearCitaMec(@PathVariable UUID id, @Valid @RequestBody CitaCreateMecanico citaCreate) {
        mecanicoService.comprobarDisponibilidad(id, citaCreate.getFechaHora());
        CitaDto newCita = CitaDtoConverter.of(service.add(citaCreateMecanicoConverter.toCita(id, citaCreate)));
        URI newURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newCita.getId()).toUri();
        return ResponseEntity.created(newURI).body(newCita);
    }

    @Operation(summary = "Modificar una cita")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Cita modificada",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CitaDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": 27,
                                                    "mecanico": "Mario Ruiz López",
                                                    "cliente": "Manuel Ruiz Benavente",
                                                    "vehiculo": "Toyota C-HR-7456BDX",
                                                    "fechaHora": "13-02-2023 15:00",
                                                    "servicios": [
                                                        "Cambio aceite",
                                                        "Cambio filtro aceite",
                                                        "Cambio filtro aire",
                                                        "Cambio filtro habitáculos",
                                                        "Cambio filtro combustible",
                                                        "Cambio distribución"
                                                    ],
                                                    "estado": "Terminada",
                                                    "imgVehiculo": [],
                                                    "chat": []
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
                                                    "message": "El mecánico asignado tiene ocupada ese día y hora",
                                                    "path": "/auth/cita/mec/27",
                                                    "statusCode": 400,
                                                    "date": "13/02/2023 17:42:43"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Cita no encontrada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra la cita con ID: 270",
                                                    "path": "/auth/cita/mec/270",
                                                    "statusCode": 404,
                                                    "date": "13/02/2023 17:43:33"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.DetallesCita.class)
    @PutMapping("/mecanico/{id}")
    public CitaDto modificarCita(@PathVariable Long id, @Valid @RequestBody CitaEditMecanico edit) {
        UUID idMecanico = userService.findByUsername(edit.getUsernameMecanico()).getId();
        mecanicoService.comprobarDisponibilidad(idMecanico, edit.getFechaHora());
        return CitaDtoConverter.ofDetails(service.edit(id, edit, mecanicoService.findById(idMecanico)));
    }

    @Operation(summary = "Eliminar una cita, buscada por su ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Cita eliminada correctamente, sin contenido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Cita.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {}
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "ID de la cita aportación inválido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "BAD_REQUEST",
                                                    "message": "No se puede cancelar una cita en proceso de realización o ya terminada",
                                                    "path": "/auth/cita/10",
                                                    "statusCode": 400,
                                                    "date": "13/02/2023 16:54:07"
                                                }
                                            """
                            )}
                    )})
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> cancelarCita(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}
