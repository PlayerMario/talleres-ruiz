package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class CitaCreateCliente {

    //@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy HH:mm")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss[.SSS][.SS][.S]")
    @CheckCitaDateHour(message = "{citaCreate.fecha.checkcitadatehour}")
    private LocalDateTime fechaHora;

}
