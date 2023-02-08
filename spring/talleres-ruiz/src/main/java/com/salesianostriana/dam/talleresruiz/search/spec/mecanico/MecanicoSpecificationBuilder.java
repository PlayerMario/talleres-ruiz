package com.salesianostriana.dam.talleresruiz.search.spec.mecanico;

import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.search.spec.generic.GenericSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;

import java.util.List;

public class MecanicoSpecificationBuilder extends GenericSpecificationBuilder<Mecanico> {

    public MecanicoSpecificationBuilder(List<SearchCriteria> params) {
        super(params, Mecanico.class, Mecanico.hiddenFields);
    }

}
