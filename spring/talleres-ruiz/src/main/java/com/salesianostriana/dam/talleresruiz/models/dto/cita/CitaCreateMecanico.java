package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UsernameExists;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CitaCreateMecanico {

    @UsernameExists(message = "{citaCreate.usernameCliente.usernameexists}")
    private String usernameCliente;

    @JsonFormat(pattern = "dd-MM-yyyy")
    @CheckCitaDateHour(message = "{citaCreate.fecha.checkcitadatehour}")
    private LocalDateTime fechaHora;

}
