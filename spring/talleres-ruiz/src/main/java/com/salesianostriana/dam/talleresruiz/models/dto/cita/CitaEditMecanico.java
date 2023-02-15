package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UserDniExists;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UserUsernameExists;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CitaEditMecanico {

    @UserUsernameExists(message = "{citaCreate.usernameMecanico.usernameexists}")
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
