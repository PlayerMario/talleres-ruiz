package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.services.MecanicoService;
import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

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
                .cliente(clienteService.findById(userService.findByDni(citaCreate.getDni()).getId()))
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
                .build();
    }

}
