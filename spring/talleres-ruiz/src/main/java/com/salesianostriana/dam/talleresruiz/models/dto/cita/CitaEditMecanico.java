package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CitaEditMecanico {

    //@JsonFormat(pattern = "dd-MM-yyyy HH:mm")
    // Para que funcione con flutter:
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss[.SSS][.SS][.S]")
    @CheckCitaDateHour(message = "{citaCreate.fecha.checkcitadatehour}")
    private LocalDateTime fechaHora;

    @NotEmpty(message = "{citaEdit.estado.notempty}")
    private String estado;

}
