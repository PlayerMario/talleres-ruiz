package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeDto;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;

@Component
public class CitaDtoConverter {

    public static CitaDto of(Cita cita) {
        return CitaDto.builder()
                .mecanico(cita.getMecanico().getUsuario().getNombre())
                .cliente(cita.getCliente().getUsuario().getNombre())
                .vehiculo(cita.getCliente().getVehiculo() + "-" + cita.getCliente().getMatricula())
                .fechaHora(cita.getFechaHora().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")))
                .estado(cita.getEstado())
                .build();
    }

    public static CitaDto ofDetails(Cita cita) {
        return CitaDto.builder()
                .id(cita.getId())
                .mecanico(cita.getMecanico().getUsuario().getNombre())
                .cliente(cita.getCliente().getUsuario().getNombre())
                .vehiculo(cita.getCliente().getVehiculo() + "-" + cita.getCliente().getMatricula())
                .fechaHora(cita.getFechaHora().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")))
                .servicios(cita.getServicios())
                .estado(cita.getEstado())
                .imgVehiculo(cita.getImgVehiculo())
                .chat(cita.getChat().stream().map(MensajeDto::of).toList())
                .build();
    }

    public static CitaDto toClienteDetalles(Cita cita) {
        return CitaDto.builder()
                .mecanico(cita.getMecanico().getUsuario().getNombre())
                .fechaHora(cita.getFechaHora().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")))
                .servicios(cita.getServicios())
                .estado(cita.getEstado())
                .build();
    }

}
