package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import org.springframework.stereotype.Component;

@Component
public class CitaDtoConverter {

    public static CitaDto toClienteDetalles(Cita cita) {
        return CitaDto.builder()
                .mecanico(cita.getMecanico().getUsuario().getNombre())
                .fechaHora(cita.getFecha() + " " + cita.getHora())
                .servicios(cita.getServicios())
                .estado(cita.getEstado())
                .build();
    }

}
