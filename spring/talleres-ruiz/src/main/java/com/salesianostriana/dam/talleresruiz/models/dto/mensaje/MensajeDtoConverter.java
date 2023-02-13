package com.salesianostriana.dam.talleresruiz.models.dto.mensaje;

import com.salesianostriana.dam.talleresruiz.models.Mensaje;
import com.salesianostriana.dam.talleresruiz.services.CitaService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class MensajeDtoConverter {

    private final CitaService citaService;
    private final UserService userService;

    public Mensaje toMensaje(Long idCita, UUID idAutor, MensajeCreate create) {
        return Mensaje.builder()
                .mensaje(create.getMensaje())
                .cita(citaService.findById(idCita))
                .autor(userService.findByIdCheck(idAutor))
                .build();
    }

}
