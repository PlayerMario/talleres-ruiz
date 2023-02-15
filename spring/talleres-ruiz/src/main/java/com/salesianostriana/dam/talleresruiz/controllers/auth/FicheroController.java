package com.salesianostriana.dam.talleresruiz.controllers.auth;

import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.models.dto.fichero.FicheroDto;
import com.salesianostriana.dam.talleresruiz.services.ficheros.FileSystemStorageService;
import com.salesianostriana.dam.talleresruiz.utils.MediaTypeUrlResource;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.URI;

@Validated
@RestController
@RequestMapping("/auth/fichero")
@RequiredArgsConstructor
@Tag(name = "Fichero", description = "Controlador para la gestión de ficheros")
public class FicheroController {

    private final FileSystemStorageService service;

    @Operation(summary = "Obtener un fichero por su nombre")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Fichero encontrado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Resource.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    [IMAGEN DEL FICHERO]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "403", description = "Acceso prohibido, necesario token de acceso",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "FORBIDDEN",
                                                    "message": "JWT expired at 2023-02-14T21:00:03Z.",
                                                    "path": "/auth/fichero/download/logo.png",
                                                    "statusCode": 403,
                                                    "date": "15/02/2023 16:53:12"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "No se encuentra el fichero",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = ApiErrorImpl.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "status": "NOT_FOUND",
                                                    "message": "No se encuentra el fichero: logo.png",
                                                    "path": "/auth/fichero/download/logo.png",
                                                    "statusCode": 404,
                                                    "date": "15/02/2023 17:08:19"
                                                }
                                            """
                            )}
                    )})
    })
    @GetMapping("/download/{nombre:.+}")
    public ResponseEntity<Resource> obtenerFichero(@PathVariable String nombre) {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) service.loadAsResource(nombre);

        return ResponseEntity.status(HttpStatus.OK)
                .header("Content-Type", resource.getType())
                .body(resource);
    }

    @Operation(summary = "Subir un fichero al servidor")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Fichero subido",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = FicheroDto.class),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "nombre": "Gear.png",
                                                    "uri": "http://localhost:8080/download/Gear.png",
                                                    "tipo": "image/png",
                                                    "tam": 18516
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
    @PostMapping("/guardar")
    public ResponseEntity<FicheroDto> guardarFichero(@RequestPart("fichero") MultipartFile fichero) {
        FicheroDto dto = service.gestionFichero(fichero);
        return ResponseEntity.created(URI.create(dto.getUri())).body(dto);
    }

}
