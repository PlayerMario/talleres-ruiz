package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CitaCreateCliente {

    @JsonFormat(pattern = "dd-MM-yyyy HH:mm")
    @CheckCitaDateHour(message = "{citaCreate.fecha.checkcitadatehour}")
    private LocalDateTime fechaHora;

    @NotEmpty(message = "{citaCreate.imgVehiculo.notempy}")
    private List<String> imgVehiculo;

}
