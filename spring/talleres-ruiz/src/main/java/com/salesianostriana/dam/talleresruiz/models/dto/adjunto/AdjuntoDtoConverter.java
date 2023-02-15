package com.salesianostriana.dam.talleresruiz.models.dto.adjunto;

import com.salesianostriana.dam.talleresruiz.models.Adjunto;
import com.salesianostriana.dam.talleresruiz.services.CitaService;
import com.salesianostriana.dam.talleresruiz.services.ficheros.FileSystemStorageService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class AdjuntoDtoConverter {

    private final CitaService citaService;
    private final UserService userService;
    private final FileSystemStorageService storageService;

    public Adjunto toAdjuntoMensaje(Long idCita, UUID idAutor, AdjuntoCreate create) {
        return Adjunto.builder()
                .contenido(create.getContenido())
                .cita(citaService.findById(idCita))
                .autor(userService.findByIdCheck(idAutor))
                .fichero(false)
                .build();
    }

    @Transactional
    public Adjunto toAdjuntoFichero(Long idCita, UUID idAutor, MultipartFile fichero) {
        return Adjunto.builder()
                .contenido(storageService.store(fichero))
                .cita(citaService.findById(idCita))
                .autor(userService.findByIdCheck(idAutor))
                .fichero(true)
                .build();
    }

}
