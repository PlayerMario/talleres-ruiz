package com.salesianostriana.dam.talleresruiz.models.dto.user;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoViews;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class UserDto {

    @JsonView({MecanicoViews.DetallesMecanicos.class, ClienteViews.DetallesClientes.class, UserViews.Master.class})
    private UUID id;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class, UserViews.Master.class})
    protected String nombre;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class, UserViews.Master.class})
    protected String username;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class})
    protected String dni;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class})
    protected String email;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class})
    protected String tlf;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class, UserViews.Master.class})
    protected String avatar;

    @JsonView({MecanicoViews.DetallesMecanicos.class, ClienteViews.DetallesClientes.class})
    protected List<String> roles;

    @JsonView(UserViews.Token.class)
    private String token;


    public UserDto(UUID id, String username, String avatar, String nombre) {
        this.id = id;
        this.username = username;
        this.nombre = nombre;
        this.avatar = avatar;
    }

    public UserDto(UUID id, String nombre, String username, String dni, String email, String tlf, String avatar) {
        this.id = id;
        this.nombre = nombre;
        this.username = username;
        this.dni = dni;
        this.email = email;
        this.tlf = tlf;
        this.avatar = avatar;
    }

}
