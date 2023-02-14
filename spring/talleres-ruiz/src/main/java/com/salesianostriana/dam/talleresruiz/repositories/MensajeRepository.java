package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Mensaje;
import com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MensajeRepository extends JpaRepository<Mensaje, Long>, JpaSpecificationExecutor<Mensaje> {

    List<Mensaje> findByAutor(User user);

    @Query("""
                 SELECT new com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeDto(
                    autor.nombre, msj.fechaHora, msj.mensaje
                 )
                 FROM Mensaje msj LEFT JOIN msj.autor autor
                 WHERE msj.id = :id
           """)
    MensajeDto generarMensajeDto(@Param("id") Long id);

    @Query("""
                 SELECT new com.salesianostriana.dam.talleresruiz.models.dto.mensaje.MensajeDto(
                    autor.nombre, msj.fechaHora, msj.mensaje
                 )
                 FROM Cita cita LEFT JOIN cita.chat msj LEFT JOIN msj.autor autor
                 WHERE cita.id = :id
           """)
    List<MensajeDto> generarChatDto(@Param("id") Long id);

}
