package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.*;
import com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeCreate;
import com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeDtoConverter;
import com.salesianostriana.dam.talleresruiz.models.dto.page.PageDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.services.CitaService;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.services.MecanicoService;
import com.salesianostriana.dam.talleresruiz.services.MensajeService;
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
import org.springframework.data.domain.Sort;
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
@RequestMapping("/auth/cita")
@RequiredArgsConstructor
@Tag(name = "Cita", description = "Controlador para la gestión de citas")
public class CitaController {

    private final CitaService service;
    private final MecanicoService mecanicoService;
    private final ClienteService clienteService;
    private final UserService userService;
    private final MensajeService mensajeService;
    private final CitaDtoConverter citaConverter;
    private final MensajeDtoConverter mensajeConverter;


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
                                                            "fechaHora": "18-01-2023 12:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "cliente": "Jose Javier Moriña León",
                                                            "vehiculo": "Kia Rio-2014GMD",
                                                            "fechaHora": "18-05-2022 10:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "mecanico": "Luis Verde Cantero",
                                                            "cliente": "Manuel Delgado Hernández",
                                                            "vehiculo": "Opel Astra-8520KMM",
                                                            "fechaHora": "02-03-2023 12:00",
                                                            "estado": "Aceptada"
                                                        },
                                                        {
                                                            "mecanico": "Alejandro Santos Pacheco",
                                                            "cliente": "Manuel Delgado Hernández",
                                                            "vehiculo": "Opel Astra-8520KMM",
                                                            "fechaHora": "08-11-2022 11:00",
                                                            "estado": "Terminada"
                                                        },
                                                        {
                                                            "mecanico": "Mario Ruiz López",
                                                            "cliente": "Manuel Delgado Hernández",
                                                            "vehiculo": "Opel Astra-8520KMM",
                                                            "fechaHora": "17-01-2022 15:00",
                                                            "estado": "Terminada"
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
            @PageableDefault(size = 5, page = 0, sort = "fechaHora", direction = Sort.Direction.DESC) Pageable pageable) {
        return service.paginarFiltrarCitas(search, pageable);
    }

    @Operation(summary = "Obtener detalles de una cita")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Cita encontrada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = CitaDto.class),
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
                                                            "fechaHora": "18-01-2023 14:10",
                                                            "mensaje": "Hola buenas, hemos visto que también necesitaría un cambio de pastillas de freno."
                                                        },
                                                        {
                                                            "autor": "Jose Javier Moriña León",
                                                            "fechaHora": "18-01-2023 14:30",
                                                            "mensaje": "Hola, en principio no se lo cambiéis, esperaré a más adelante."
                                                        }
                                                    ]
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
        return service.generarCitaDtoDetails(service.mostrarCitaConChat(id));
    }

    @Operation(summary = "Crear nueva cita en vista mecánico")
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
    })
    @JsonView(CitaViews.Master.class)
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/mecanico/me")
    public ResponseEntity<CitaDto> crearCitaMec(@AuthenticationPrincipal User usuario, @Valid @RequestBody CitaCreateMecanico citaCreate) {
        mecanicoService.comprobarDisponibilidad(usuario.getId(), citaCreate.getFechaHora());
        CitaDto newCita = service.generarCitaDto(service.add(citaConverter.toCitaMecanico(usuario.getId(), citaCreate)));
        return service.crearCita(newCita);
    }

    @Operation(summary = "Crear nueva cita en vista cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Cita creada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = CitaDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "mecanico": "Por asignar",
                                                    "cliente": "Manuel Ruiz Benavente",
                                                    "vehiculo": "Toyota C-HR-7456BDX",
                                                    "fechaHora": "13-02-2023 15:00",
                                                    "estado": "Trámite",
                                                    "imgVehiculo": [
                                                        ...
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
                                                    "path": "/auth/cita/cliente/f7d699b1-d7fd-4408-990a-5287b3229597",
                                                    "statusCode": 400,
                                                    "date": "13/02/2023 19:18:59",
                                                    "subErrors": [
                                                        {
                                                            "object": "citaCreateCliente",
                                                            "message": "Al menos debe introducir la imagen del cuenta kilómetros",
                                                            "field": "imgVehiculo"
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
                                                    "path": "/auth/cita/cliente",
                                                    "statusCode": 403,
                                                    "date": "14/02/2023 09:24:58"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.NuevaCitaCliente.class)
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/cliente")
    public ResponseEntity<CitaDto> crearCitaCliente(@AuthenticationPrincipal User usuario, @Valid @RequestBody CitaCreateCliente citaCreate) {
        clienteService.comprobarDisponibilidad(usuario.getId(), citaCreate.getFechaHora());
        CitaDto newCita = service.citaCliente(service.add(citaConverter.toCitaCliente(usuario.getId(), citaCreate)));
        return service.crearCita(newCita);
    }

    @Operation(summary = "Agregar mensaje al chat de una cita")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Mensaje agregado a la cita",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = CitaDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": 23,
                                                    "mecanico": "Mario Ruiz López",
                                                    "cliente": "Laura Gordillo Moreno",
                                                    "vehiculo": "Seat Ibiza-5877FCD",
                                                    "fechaHora": "30-03-2023 10:30",
                                                    "servicios": [
                                                        "Cambio aceite",
                                                        "Cambio filtro aceite",
                                                        "Cambio filtro combustible"
                                                    ],
                                                    "estado": "Aceptada",
                                                    "imgVehiculo": [],
                                                    "chat": [
                                                        {
                                                            "autor": "Laura Gordillo Moreno",
                                                            "fechaHora": "20-02-2022 16:35",
                                                            "mensaje": "Cuando freno chirría un poco."
                                                        },
                                                        {
                                                            "autor": "Mario Ruiz López",
                                                            "fechaHora": "20-02-2022 17:40",
                                                            "mensaje": "Le echamos un vistazo y te decimos con lo que sea."
                                                        },
                                                        {
                                                            "autor": "Mario Ruiz López",
                                                            "fechaHora": "13-02-2023 20:49",
                                                            "mensaje": "Hay que cambiar las pastillas de freno."
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400", description = "Cuerpo para la adición aportado inválido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "BAD_REQUEST",
                                                    "message": "La cita no pertenece al usuario que intenta enviar el mensaje",
                                                    "path": "/auth/cita/1/mensaje/3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "statusCode": 400,
                                                    "date": "13/02/2023 20:36:25"
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
            @ApiResponse(responseCode = "404", description = "Cita no encontrada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra la cita con ID: 100",
                                                    "path": "/auth/cita/100/mensaje/3e380d54-861c-4809-bb84-bd32bab42c2e",
                                                    "statusCode": 404,
                                                    "date": "13/02/2023 20:42:02"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.DetallesCita.class)
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/{id}/mensaje")
    public CitaDto nuevoMensaje(@PathVariable Long id, @AuthenticationPrincipal User usuario, @Valid @RequestBody MensajeCreate mensajeCreate) {
        service.comprobarEstadoAutor(id, usuario.getId());
        mensajeService.add(mensajeConverter.toMensaje(id, usuario.getId(), mensajeCreate));
        return service.generarCitaDtoDetails(service.mostrarCitaConChat(id));
    }


    @Operation(summary = "Modificar una cita en vista mecánico")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Cita modificada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = CitaDto.class),
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
    public CitaDto modificarCitaMec(@PathVariable Long id, @Valid @RequestBody CitaEditMecanico edit) {
        UUID idMecanico = userService.findByUsername(edit.getUsernameMecanico()).getId();
        mecanicoService.comprobarDisponibilidadModif(idMecanico, id, edit.getFechaHora());
        return service.generarCitaDtoDetails(service.edit(id, edit, mecanicoService.findById(idMecanico)));
    }

    @Operation(summary = "Modificar una cita en vista cliente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Cita modificada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = CitaDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "mecanico": "Por asignar",
                                                    "cliente": "Manuel Ruiz Benavente",
                                                    "vehiculo": "Toyota C-HR-7456BDX",
                                                    "fechaHora": "13-02-2023 15:00",
                                                    "estado": "Trámite",
                                                    "imgVehiculo": [
                                                        "https://i.ytimg.com/vi/VaVWYF7mZxY/maxresdefault.jpg"
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
                                                    "message": "Ya tiene una cita asignada para el día y hora elegido",
                                                    "path": "/auth/cita/cliente/f7d699b1-d7fd-4408-990a-5287b3229597/27",
                                                    "statusCode": 400,
                                                    "date": "13/02/2023 19:53:32"
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
                                                    "path": "/auth/cita/cliente",
                                                    "statusCode": 403,
                                                    "date": "14/02/2023 09:24:58"
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
                                                    "path": "/auth/cita/cliente/f7d699b1-d7fd-4408-990a-5287b3229597/270",
                                                    "statusCode": 404,
                                                    "date": "13/02/2023 19:54:19"
                                                }
                                            """
                            )}
                    )})
    })
    @JsonView(CitaViews.NuevaCitaCliente.class)
    @PreAuthorize("isAuthenticated()")
    @PutMapping("/cliente/{id}")
    public CitaDto modificarCitaCliente(@AuthenticationPrincipal User usuario, @PathVariable Long id, @Valid @RequestBody CitaCreateCliente edit) {
        clienteService.comprobarDisponibilidadModif(usuario.getId(), id, edit.getFechaHora());
        return service.citaCliente(service.editCliente(usuario.getId(), id, edit));
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
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> cancelarCita(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}
