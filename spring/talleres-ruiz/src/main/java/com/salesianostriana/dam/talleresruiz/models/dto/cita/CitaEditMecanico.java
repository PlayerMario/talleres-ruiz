package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UsernameExists;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CitaEditMecanico {

    @UsernameExists(message = "{citaCreate.usernameCliente.usernameexists}")
    @NotEmpty(message = "{citaEdit.idmecanico.notempty}")
    private String usernameMecanico;

    @JsonFormat(pattern = "dd-MM-yyyy HH:mm")
    @CheckCitaDateHour(message = "{citaCreate.fecha.checkcitadatehour}")
    private LocalDateTime fechaHora;

    @NotEmpty(message = "{citaEdit.estado.notempty}")
    private String estado;

    @NotEmpty(message = "{citaEdit.servicios.notempty}")
    private List<String> servicios;

}
