package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.*;
import org.hibernate.annotations.NaturalId;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "mecanico")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Mecanico {

    @Id
    private UUID id;

    @MapsId
    @JsonIgnore
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_MECANICO_USER"), columnDefinition = "uuid")
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private User usuario;

    @JsonIgnore
    public static String hiddenFields = "id";

}
