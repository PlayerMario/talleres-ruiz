package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeDto;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.services.MecanicoService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class CitaDtoConverter {

    private final MecanicoService mecanicoService;
    private final ClienteService clienteService;
    private final UserService userService;

    public Cita toCitaMecanico(UUID id, CitaCreateMecanico citaCreate) {
        return Cita.builder()
                .mecanico(mecanicoService.findById(id))
                .cliente(clienteService.findById(userService.findByUsername(citaCreate.getUsernameCliente()).getId()))
                .fechaHora(citaCreate.getFechaHora())
                .estado("Aceptada")
                .build();
    }

    public Cita toCitaCliente(UUID id, CitaCreateCliente citaCreate) {
        return Cita.builder()
                .mecanico(null)
                .cliente(clienteService.findById(id))
                .fechaHora(citaCreate.getFechaHora())
                .estado("Trámite")
                .imgVehiculo(citaCreate.getImgVehiculo())
                .build();
    }

    public static CitaDto of(Cita cita) {
        String mec = cita.getMecanico() != null ? cita.getMecanico().getUsuario().getNombre() : "Por asignar";
        return CitaDto.builder()
                .mecanico(mec)
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
        String mec = cita.getMecanico() != null ? cita.getMecanico().getUsuario().getNombre() : "Por asignar";
        return CitaDto.builder()
                .mecanico(mec)
                .fechaHora(cita.getFechaHora().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")))
                .servicios(cita.getServicios())
                .estado(cita.getEstado())
                .build();
    }

    public static CitaDto ofNuevaCliente(Cita cita) {
        CitaDto citaDto = of(cita);
        citaDto.setMecanico("Por asignar");
        citaDto.setImgVehiculo(cita.getImgVehiculo());
        return citaDto;
    }

}
