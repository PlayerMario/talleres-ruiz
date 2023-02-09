package com.salesianostriana.dam.talleresruiz.search.spec.mensaje;

import com.salesianostriana.dam.talleresruiz.models.Mensaje;
import com.salesianostriana.dam.talleresruiz.search.spec.generic.GenericSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;

import java.util.List;

public class MensajeSpecificationBuilder extends GenericSpecificationBuilder<Mensaje> {

    public MensajeSpecificationBuilder(List<SearchCriteria> params) {
        super(params, Mensaje.class, Mensaje.hiddenFields);
    }

}
