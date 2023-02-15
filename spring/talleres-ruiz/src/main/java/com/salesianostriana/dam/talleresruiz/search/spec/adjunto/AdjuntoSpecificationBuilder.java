package com.salesianostriana.dam.talleresruiz.search.spec.adjunto;

import com.salesianostriana.dam.talleresruiz.models.Adjunto;
import com.salesianostriana.dam.talleresruiz.search.spec.generic.GenericSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;

import java.util.List;

public class AdjuntoSpecificationBuilder extends GenericSpecificationBuilder<Adjunto> {

    public AdjuntoSpecificationBuilder(List<SearchCriteria> params) {
        super(params, Adjunto.class, Adjunto.hiddenFields);
    }

}
