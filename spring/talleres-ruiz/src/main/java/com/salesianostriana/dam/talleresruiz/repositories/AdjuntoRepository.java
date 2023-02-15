package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Adjunto;
import com.salesianostriana.dam.talleresruiz.models.dto.adjunto.AdjuntoDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AdjuntoRepository extends JpaRepository<Adjunto, Long>, JpaSpecificationExecutor<Adjunto> {

    List<Adjunto> findByAutor(User user);

    @Query("""
                 SELECT new com.salesianostriana.dam.talleresruiz.models.dto.adjunto.AdjuntoDto(
                    autor.nombre, ad.fechaHora, ad.contenido, ad.fichero
                 )
                 FROM Adjunto ad LEFT JOIN ad.autor autor
                 WHERE ad.id = :id
           """)
    AdjuntoDto generarMensajeDto(@Param("id") Long id);

    @Query("""
                 SELECT new com.salesianostriana.dam.talleresruiz.models.dto.adjunto.AdjuntoDto(
                    autor.nombre, ad.fechaHora, ad.contenido, ad.fichero
                 )
                 FROM Cita cita LEFT JOIN cita.chat ad LEFT JOIN ad.autor autor
                 WHERE cita.id = :id
           """)
    List<AdjuntoDto> generarChatDto(@Param("id") Long id);

}
