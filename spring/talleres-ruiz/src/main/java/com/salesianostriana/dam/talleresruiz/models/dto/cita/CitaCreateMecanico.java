package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UserDniExists;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CitaCreateMecanico {

    @UserDniExists(message = "{citaCreate.dni.userdniexists}")
    @NotEmpty(message = "{citaCreate.dni.notempty}")
    private String dni;

    @JsonFormat(pattern = "dd-MM-yyyy HH:mm")
    @CheckCitaDateHour(message = "{citaCreate.fecha.checkcitadatehour}")
    private LocalDateTime fechaHora;

}
