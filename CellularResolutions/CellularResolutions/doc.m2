
beginDocumentation()

doc ///
    Key
        CellularResolutions
    Headline
        A package for cellular resolutions of monomial ideals
    Description
        Text
            This package aims to make working with cellular resolutions of
            monomial ideals possible. The package additionally provides basic
            functions to work with cell complexes, although the focus is on
            those constructs needed to construct cellular resolutions. For
            some direct ways to construct common cellular resolutions see
            @TO taylorComplex@ and @TO hullComplex@.
///

doc ///
    Key
        CellComplex
    Headline
        the class of all cell complexes
    Description
        Text
            A cell complex in this context is the combinatorial data of a
            CW-complex, i.e. a collection of cells in various dimensions along
            with their boundary expressed as a sequence of cells along with an
            orientation such that the boundary is a cycle.
    Caveat
        Not every object represented by a @CODE "CellComplex"@ object
        corresponds to a topological cell complex. In general there is no
        way to check that such a topological realization exists.
///

doc ///
    Key
        Cell
    Headline
        the class of all cells in cell complexes
    Description
        Text
            This class represents a single cell in a cell complex. A cell has
            a boundary, a dimension, and a label. In most cases, the label should
            be a monomial. But the cells in this package may be anything.
            However for functions such as @TO chainComplex@ to work, the labels
            should be either monomials, ideals, or modules.
            In the monomial case, we can view the label as a module by taking
            the submodule generated by the ring, and then there should be
            canonical inclusions maps from the label on any cell to the labels
            of the cells in its boundary.
    SeeAlso
        CellComplex
        cellLabel
///

doc ///
    Key
        cellComplex
        (cellComplex,Ring,List)
    Headline
        create a cell complex
    Usage
        cellComplex(R,maxCells)
    Inputs
        R : Ring
            that specifies the base ring for interpreting the labels
        maxCells : List
            that specifies the maximal cells for the complex
    Outputs
        : CellComplex
            a cell complex
    Description
        Text
            The method cellComplex takes a ring R and a list of maximal cells and constructs the
            corresponding cell complex. While the intent is for the supplied cells to be maximal,
            including non-maximal cells is not forbiden and will generate valid cell complexes.
        Text
            The ring R is the ring over which the labels are interpreted. This function does not
            directly check that the labels are in the correct ring.
        Example
            c = newCell {}
            C = cellComplex(QQ,{c});
            R = QQ[x,y];
            C = cellComplex(R,{c});
    SeeAlso
        (newCell,List)
        (newCell,List,Thing)
///

doc ///
    Key
        newCell
        (newCell,List,Thing)
        (newCell,List)
        CellDimension
        [newCell,CellDimension]
    Headline
        creates a new cell
    Usage
        newCell(boundary,label)
        newCell(boundary)
    Inputs
        boundary : List
            that gives the boundary of the new cell either as a list of pairs
            of cells and their orientation, or a list of cells.
        label : Thing
            that gives a label to associate to the cell, otherwise attempt to
            infer it based on the labels on the boundary
    Outputs
        : Cell
            that was created
    Description
        Text
            This function creates a new cell, to be added to a cell complex,
            if given a list of cells without any orientation information, it
            attempts to infer the orientation.
        Text
            If given an empty list for the boundary, the function creates a
            0-cell (a vertex).
        Text
            If not given a label, and the labels on the boundary are monomials
            or monomial ideals, from the same ring, then the label is the lcm
            of the labels of the boundary
        Text
            If the dimension cannot be directly infered from the boundary,
            CellDimension can be used to specify the true dimension
        Example
            R = QQ[x,y]
            a = newCell({},x);
            b = newCell({},y);
            c1 = newCell {(a,1),(a,-1)};
            c2 = newCell {a,a};
            c3 = newCell {a,b};
            C = cellComplex(R,{c1,c2,c3});
    Caveat
        This function does not check that there is a valid map from the boundary
        of a n-cell to the given boundary. It only checks that the boundary
        forms a cycle in homology.
    SeeAlso
        cellComplex
        newSimplexCell
///

doc ///
    Key
        newSimplexCell
        (newSimplexCell,List,Thing)
        (newSimplexCell,List)
    Headline
        create a new cell
    Usage
        newSimplexCell(boundary,label)
        newSimplexCell(boundary)
    Inputs
        boundary : List
            that gives the boundary of the new cell either as a list of pairs
            of cells and their orientation, or a list of cells.
        label : Thing
            that gives a label to associate to the cell, otherwise attempt to
            infer it based on the labels on the boundary
    Outputs
        : Cell
            that was created
    Description
        Text
            This function will only create simplices, and it will verify that
            the new cell is a simplex, as such does not have the caveat of
            @TO newCell@. Otherwise it has the same behavior. This is
            particularly useful in constructing \Delta-complexes.
	Example 
	    v1 = newSimplexCell {};
	    v2 = newSimplexCell {};
	    e1 = newSimplexCell {v1,v2};
	    e2 = newSimplexCell {(v1,1),(v2,-1)};
	    C = cellComplex(ZZ, {e1,e2});
	Text 
	    One cannot use this command to create cells that are not simplices.
    SeeAlso
        cellComplex
        newCell
	isSimplex
///

doc ///
    Key 
    	(cellComplex,SimplicialComplex)
    Headline 
    	Creates a cell complex from a given simplicial complex
    Usage 
    	cellComplex D 
    Inputs 
    	D : SimplicialComplex 
    Outputs 
    	: CellComplex 
	    a cell complex that matches those of the given simplicial complex 
    Description 
    	Text 
	    This returns a cellular complex whose faces are those of the given simplicial complex. These faces are labeled as they are in the simplicial complex. 
	Example 
	    R = QQ[a..f];
	    I = monomialIdeal(a*f, b*d, c*e);
	    Delta = simplicialComplex I;
	    C = cellComplex(Delta)
    SeeAlso 
    	cellComplex 
///

doc ///
    Key 
    	(ring,CellComplex)
    Headline 
    	return the base ring of a cell complex
    Usage 
    	ring C
    Inputs 
    	C : CellComplex 
    Outputs
    	: Ring 
	    the base ring of the cell complex C
    Description 
    	Text
	    This returns the base ring associated to a cell complex C, which is used to interpret labels. 
	Example 
	    R = QQ[x,y];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y^2);
	    e = newSimplexCell {vx,vy};
	    C = cellComplex(R,{e});
	    ring(C)
    SeeAlso 
    	cellComplex
///

doc /// 
    Key 
    	cellLabel 
	(cellLabel,Cell)
    Headline 
    	return the label of a cell 
    Usage 
    	cellLabel C
    Inputs
    	C : Cell 
    Outputs
    	: Thing 
	    the label of the cell
    Description
        Text
            The label is provided at the creation of the cell and cannot be modified, neither
            this function nor any of the cell creation functions attempt to interpret the label
            and while the labels generally should be monomials, this package makes no attempt
            to enforce such a requirement.
        Example
	    R = QQ[x,y];
	    v1 = newSimplexCell({},x^2);
	    v2 = newSimplexCell({},x*y^2);
	    v3 = newSimplexCell {};
	    e = newSimplexCell {v1,v2};
	    C = cellComplex(R,{e,v3});
	    cellLabel v1
	    cellLabel e
	    cellLabel v3
    SeeAlso
    	Cell
        newSimplexCell
        newCell
///

doc ///
    Key
        (dim,CellComplex)
    Headline
        compute the dimension of a cell complex
    Usage
        dim C
    Inputs
        C : CellComplex
            the complex to compute the dimension of
    Outputs
        : ZZ
            the dimension of the complex
    Description
        Text
            Given a cell complex C, dim returns its dimension.
            The dimension is equal to the largest dimension of a cell in C.
    	Example 
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    exy = newSimplexCell {vx,vy};
	    C = cellComplex(R,{exy,vz});
	    dim C
    SeeAlso
        (dim,Cell)
///

doc ///
    Key
        (dim,Cell)
    Headline
        compute the dimension of a cell
    Usage
        dim C
    Inputs
        C : Cell
            the cell to compute the dimension of
    Outputs
        : ZZ
            the dimension of the cell
    Description
        Text
            Given a cell C, dim returns its dimension.
            In general the dimension of the cell is infered from the
            dimension of its boundary however, this can be overridden
            if the cell is created using @TO newCell@ with the @TO CellDimension@
            option.
    	Example 
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    exy = newSimplexCell {vx,vy};
	    C = cellComplex(R,{exy,vz});
	    dim(vz)
	    dim(exy)
    SeeAlso
        (dim,CellComplex)
///

doc ///
    Key
    	cells 
    	(cells,CellComplex)
    Headline 
    	return the cells of a cell complex as a hashtable whose keys are cell dimensions
    Usage
    	cells(C)
    Inputs 
    	C : CellComplex  
	    the CellComplex whose cells are to be returned 
    Outputs 
    	: HashTable 
	    the cells of C 
    Description
        Text
            Given a cell complex, this function will return all the cells in that cell complex,
            index by dimension. The order of the cells in each dimension is arbitrary.
        Example
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    exy = newSimplexCell {vx,vy};
	    C = cellComplex(R,{exy,vz});
	    cells(C)
	Example
	    R = QQ;
	    P = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
	    C = cellComplex(R,P);
	    cells C
    SeeAlso
    	(cells,ZZ,CellComplex)
    	
///

doc /// 
    Key
	(cells,ZZ,CellComplex)
    Headline 
    	return the cells of a cell complex 
    Usage 
    	cells(ZZ,C)
    Inputs 
    	r : ZZ
	    the dimension of the cells to be returned 
    	C : CellComplex 
	    the CellComplex whose r-cells are to be returned
    Outputs
    	: List 
	    the r-cells of C
    Description
        Text
            Given a dimension r and a cell complex C, cells returns a list of all the cells
            of dimension r in C. The order of the returned cells is arbitrary.
    	Example 
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    exy = newSimplexCell {vx,vy};
	    C = cellComplex(R,{exy,vz});
	    cells(0,C)
	    cells(1,C)
	    cells(2,C)
    SeeAlso 
    	(cells,CellComplex)
///

doc ///
    Key 
    	boundary
	(boundary,Cell)
    Headline 
    	returns the boundary cells along with relative orientations
    Usage 
    	boundary(C)
    Inputs 
    	C : Cell 
    Outputs 
    	: List 
	    two-element sequences where the first element is the boundary cell and the second element is the orientation of the boundary cell relative to C    
    Description
        Text
	    Given a cell C, this command returns a list whose elements are two-element sequences.
            The first element of each tuple is a boundary cell of C and the second element
            is the attaching degree of that boundary cell relative to C.
	    This differs from @TO boundaryCells@ in that it returns the boundary cells and
            their corresponding attaching degree, whereas boundaryCells returns only the boundary cells.
	Example 
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    exy = newSimplexCell {vx,vy};
	    C = cellComplex(R,{exy,vz});
	    boundary(exy)
	    boundary(vz)
        Example
	    R = QQ;
	    P = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
	    C = cellComplex(R,P);
	    f = (cells(2,C))#0;
	    boundary(f)
    SeeAlso
    	(boundaryCells,Cell)
///

doc /// 
    Key 
    	boundaryCells
	(boundaryCells,Cell)
    Headline 
    	returns the boundary cells of the given cell
    Usage 
    	boundaryCells(C)
    Inputs
    	C : Cell
	    the cell whose boundary is to be returned 
    Outputs 
    	: List
	    the cells in the boundary of C 
    Description 
    	Text 
	    Given a cell C, this command returns a list whose elements are the boundary cells of C. 
	    This differs from @TO boundary@ in that it returns returns only the boundary cells of C,
            whereas boundaryCells returns a list of two-element sequences of the boundary cells and
            their corresponding orientation.
	Example
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    exy = newSimplexCell {vx,vy};
	    C = cellComplex(R,{exy,vz});
	    boundaryCells(exy)
	    boundaryCells(vz)	    	
	Example 
	    R = QQ;
	    P = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
	    C = cellComplex(R,P);
	    f = (cells(2,C))#0;
	    boundaryCells(f)
    SeeAlso 
    	(boundary,ZZ,CellComplex)
///

doc /// 
    Key  
	(boundary,ZZ,CellComplex) 
    Headline 
    	compute the boundary map of a cell complex from r-faces to (r-1)-faces 
    Usage 
    	boundary(ZZ,CellComplex) 
    Inputs 
    	r : ZZ
	    the source cell-dimension 
	C : CellComplex 
	    the CellComplex 
    Outputs 
    	: Matrix 
	    the boundary map from r-faces to (r-1)-faces of C
    Description
        Text
            This function returns the map in the chain complex from the r-th homological degree
            to the (r-1)-th homological degree.
        Text
            For example, below we construct the taylor complex for the monomial ideal $\langle x,y,z\rangle$
        Example
            R = QQ[x,y,z];
            vx = newSimplexCell({},x);
            vy = newSimplexCell({},y);
            vz = newSimplexCell({},z);
            exy = newSimplexCell {vx,vy};
            exz = newSimplexCell {vx,vz};
            eyz = newSimplexCell {vy,vz};
            f = newSimplexCell {exy,exz,eyz};
            C = cellComplex(R,{f});
            d1 = boundary_1 C
            d2 = boundary_2 C
            assert(d1*d2==0)
    SeeAlso 
        (chainComplex,CellComplex)
        -- (boundary,SimplicialComplex) this command was changed in the SimplicialComplex package
        (chainComplex,SimplicialComplex) 
///

doc ///
    Key
        (chainComplex,CellComplex)
	Reduced
	[(chainComplex,CellComplex),Reduced]
        Prune
        [(chainComplex,CellComplex),Prune]
    Headline
        compute the cellular chain complex for a cell complex
    Usage
        chainComplex C
    Inputs
        C : CellComplex
            the cell complex for which to compute the chain complex
    Outputs
        : ChainComplex
            the dimension of the complex
    Description
        Text
            This constructs the cellular chain complex for a cell complex,
            taking into account the labels on the cells. The resulting
            cell complex will be a complex of modules over the ring
            associated to the cell complex.
            By default, the option "Reduced" is set to true, so
	    the resulting ChainComplex has a rank 1 free module in homological degree -1.
        Example
            R = QQ[x]
            a = newSimplexCell({},x);
            b1 = newCell {a,a};
            b2 = newCell {a,a};
            C = cellComplex(R,{b1,b2});
            chainComplex C
	    chainComplex(C,Reduced=>false)
        Text
            For details see Combinatorial Commutative Algebra Section 4.1.
            If we restrict to the case of monomial labels, The subject to
            some acyclicity conditions, the resulting complex will be
            (up to a shift by 1 in homological degree) a resolution of $S/I$ where $I$ is
            the ideal generated by the labels of the verticies.
            Or with the "Reduced" option set to false, the resulting complex will
            be a resolution of the ideal $I$ as a module.
        Example
            R = QQ[x,y,z];
            I = ideal(x,y,z);
            vx = newSimplexCell({},x);
            vy = newSimplexCell({},y);
            vz = newSimplexCell({},z);
            exy = newSimplexCell({vx,vy});
            exz = newSimplexCell({vx,vz});
            eyz = newSimplexCell({vy,vz});
            f = newSimplexCell({exy,exz,eyz});
            C = cellComplex(R,{f});
            betti chainComplex(C)[-1]
            assert(betti chainComplex(C)[-1] == betti res I);
        Text
            The option "Prune", also defaulted to true, controls whether the modules in the complex
            are pruned before being returned. With the "Prune" option set to the default of true,
            the resulting complex is visually nicer. However, unless the labeling ring is
            fine graded, some of the structure will be lost.
        Example
            R = QQ[x,y]
            a = newSimplexCell({},x);
            b = newSimplexCell({},y);
            e = newCell {a,b};
            C = cellComplex(R,{e});
            chainComplex C
            chainComplex(C,Prune=>false)
    SeeAlso
        (boundary,ZZ,CellComplex)
	-- (boundary,SimplicialComplex) this command was changed in the SimplicialComplex package
        (chainComplex,SimplicialComplex)
        (homology,CellComplex)
        (homology,ZZ,CellComplex)
        (cohomology,ZZ,CellComplex)
///

doc ///
    Key
        (homology,CellComplex)
    Headline
        compute the homology modules of a cell complex
    Usage
        homology(C)
    Inputs
        C : CellComplex
            a cell complex with labels in ring(C)
    Outputs
        : GradedModule
            the graded module, the homology of C with coefficients in ring(C)
    Description 
    	Text 
	    This computes the reduced homology of the cellular complex arising from the labeled cell complex C.
        Text
            If the labels are all 1, then this will be the standard homology of the cell complex over
            the label ring, as in the following example
	Example
	    R = QQ[x]
            a = newSimplexCell({},1);
            b1 = newCell {a,a};
            b2 = newCell {a,a};
            C = cellComplex(R,{b1,b2});
	    HH C
	    prune oo
        Text
            However if the cells instead labeled with monomials (or monomial ideals) from the ring
            the homology of the corresponding complex of R modules is given.
	Example
	    R = QQ[x]
            a = newSimplexCell({},x);
            b1 = newCell {a,a};
            b2 = newCell {a,a};
            C = cellComplex(R,{b1,b2});
	    HH C
	    prune oo
    SeeAlso
        (homology,ZZ,CellComplex)
        (chainComplex,CellComplex)
///

doc ///
    Key
        (homology,ZZ,CellComplex)
    Headline
        compute the homology modules of a cell complex
    Usage
        homology(r,C)
    Inputs
        r : ZZ
	    an integer
	C : CellComplex
            a cell complex with labels in ring(C)
    Outputs
        : Module
            the r-th homology module of C with coefficients in ring(C)
    Description 
    	Text 
	    This computes the reduced homology in degree r of the cellular complex arising from the cell complex C.
            For more details on the labels, see @TO (homology,CellComplex)@. As an example, we can 
            compute the 0-th and 1st homology of a wedge of two circles, 
	Example
	    R = QQ
            a = newSimplexCell({},1);
            b1 = newCell {a,a};
            b2 = newCell {a,a};
            C = cellComplex(R,{b1,b2});
	    homology(0,C)
	    homology(1,C)
	    prune oo
        Text
            We can make this example slightly more interesting by changing the label ring and
            adding a non-unit label. Note in particular that this has a non-zero 0-th homology
        Example
	    R = QQ[x]
            a = newSimplexCell({},x);
            b1 = newCell {a,a};
            b2 = newCell {a,a};
            C = cellComplex(R,{b1,b2});
	    homology(0,C)
            prune oo
	    homology(1,C)
	    prune oo
    SeeAlso
        (homology,CellComplex)
	(cohomology,ZZ,CellComplex)
        (chainComplex,CellComplex)
///

doc /// 
    Key 
        (cohomology,ZZ,CellComplex) 
    Headline 
    	cohomology of a cell complex 
    Usage 
    	cohomology(r,C) 
    Inputs 
    	r: ZZ 
	    a non-negative integer 
	C : CellComplex 
    Outputs 
    	: Module 
	    the r-th cohomology module of C
    Description
        Text
            This computes the reduced cohomology in degree r of the labeled cell complex.
            In particular, it constructs the co-chain complex by dualizing by
            the label ring, and takes the homology of that chain complex. As an example
            we can compute the cohomology of the wedge of two circles
    	Example 
	    R = QQ[x]
            a = newSimplexCell({},x);
            b1 = newCell {a,a};
            b2 = newCell {a,a};
            C = cellComplex(R,{b1,b2});
	    cohomology(-1,C)
	    cohomology(0,C)
	    cohomology(1,C)
        Text
            Or in a more interesting case, we have the cohomology over the integers of
            $RP^3$
        Example
            C = cellComplexRPn(ZZ,3);
            cohomology(0,C)
            cohomology(1,C)
            cohomology(2,C)
            cohomology(3,C)
    SeeAlso
    	(homology,CellComplex)
	(homology,ZZ,CellComplex)
        (chainComplex,CellComplex)
///

doc ///
    Key 
    	isMinimal
    	(isMinimal,CellComplex)
    Headline 
    	check if a labeled cell complex supports a minimal resolution 
    Usage 
    	isMinimal C
    Inputs
    	C : CellComplex 
	    a cell complex 
    Outputs
    	: Boolean
	    true if the cellular resolution supported on C is minimal
	    false otherwise
    Description
    	Text 
	    This determines whether the cell complex C supports a minimal free resolution of the monomialIdeal I generated by the labels of the vertices of C. 
	    Note: we assume the cell complex is free. 
	Example 
	    R = QQ[x,y,z];
	    v1 = newCell({},x^2*y);
	    v2 = newCell({},y*z);
	    v3 = newCell({},z^3);
	    e12 = newCell({v1,v2});
	    e13 = newCell({v1,v3});
	    e23 = newCell({v2,v3});
	    f123 = newCell({e12,e13,e23});
	    C = cellComplex(R,{e12,e23});
	    isMinimal C
	    D = cellComplex(R,{f123});
	    isMinimal D
///

doc /// 
    Key
        isSimplex
        (isSimplex,Cell)
    Headline 
    	check if a cell is a simplex 
    Usage 
    	isSimplex C 
    Inputs 
    	C : Cell 
	    a cell
    Outputs 
    	: Boolean 
	    true if the cell C is a simplex 
	    false otherwise 
    Description 
    	Text
	    This determines whether a cell C is a simplex. 
	Example
	    v1 = newCell {};
	    v2 = newCell {};
	    e1 = newCell {v1,v2};
	    isSimplex e1
	    e2 = newCell {v1,v1};
	    isSimplex e2
///

doc /// 
    Key 
        isCycle
	(isCycle,List)
    Headline 
    	checks if a list of cells with orientation make a cycle 
    Usage 
    	isCycle L
    Inputs 
    	L : List
	    whose entries are pairs, whose first entry is a cell and whose second entry is a degree
    Outputs
    	: Boolean
	    true if the given cell-degree pairs form a cycle
	    false otherwise
    Description
    	Text 
	    This determines whether the given pairs, whose first entry is a cell and whose second entry is its degree of attachment, 
	    form a cycle in the homological sense. 
	Example 
	    R = QQ[x,y,z];
	    vx = newSimplexCell({},x);
	    vy = newSimplexCell({},y);
	    vz = newSimplexCell({},z);
	    lxy = newSimplexCell({vx,vy});
	    lyz = newSimplexCell({vy,vz});
	    lxz = newSimplexCell({vx,vz});
	    assert(isCycle {(lxy,1)} == false);
	    assert(isCycle {{lxy,1},{lyz,1},{lxz,-1}} == true);
	    assert(isCycle {{lxy,1},{lyz,1},{lxz,1}} == false);
///

doc /// 
    Key 
    	(facePoset,CellComplex)
    Headline
    	generates the face poset of a cell complex 
    Usage 
        facePoset C
    Inputs 
    	C : CellComplex 
	    a cell complex
    Outputs 
    	: Poset
	    the face poset of C 
    Description 
    	Text
	    The face poset of a cell complex is the poset of cells with partial ordering given by inclusion. 
	Example
	    R = QQ;
	    v1 = newCell {};
	    v2 = newCell {};
	    v3 = newCell {};
	    v4 = newCell {};
	    e12 = newCell({v1,v2});
	    e23 = newCell({v2,v3});
	    e34 = newCell({v3,v4});
	    e41 = newCell({v4,v1});
	    f = newCell({e12,e23,e34,e41});
	    C = cellComplex(R,{f});
	    facePoset C
///

doc /// 
    Key 
    	(skeleton,ZZ,CellComplex)
    Headline 
    	returns the $r$-skeleton of a cell complex 
    Usage 
    	skeleton(ZZ,CellComplex)
    Inputs 
    	r : ZZ 
    	C : CellComplex
	    a cell complex 
    Outputs 
    	: CellComplex 
	    the $r$-skeleton of the cell complex $C$
    Description 
    	Text 
	    The $r$-skeleton of a cell complex is the union of its cells whose dimension is at most $r$. 
	Example 
	    R = QQ[x];
	    P = hypercube 3;
	    C = cellComplex(R,P);
	    dim C
	    cells C
	    S = skeleton(2,C);
	    dim S
	    cells S
///

doc /// 
    Key
    	isFree
	(isFree,CellComplex)
    Headline 
    	checks if the labels of a cell complex are free modules
    Usage 
    	isFree(CellComplex)
    Inputs 
    	C : CellComplex 
	    a cell complex 
    Outputs 
        : Boolean 
	    true if all modules associated to the cell labels are free 
    Description 
    	Text 
	    This command checks if the modules associated to the labels in the cell complex are all free,
            which is necessary for the complex to give a free resolution.
	Example 
	    R = QQ[x,y,z];
	    v1 = newCell({},ideal(x,y));
	    C1 = cellComplex(R,{v1});
	    isFree C1
	    v2 = newCell({},x*y);
	    C2 = cellComplex(R,{v2});
	    isFree C2
/// 

doc ///
    Key
        LabelFunction
    Description
        Text
            This optional parameter allows one to supply a function to give labels to the verticies
            of a cell complex coming from a Polyhedron or PolyhedralComplex
///

doc /// 
    Key 
    	(cellComplex,Ring,Polyhedron)
        [(cellComplex,Ring,Polyhedron),LabelFunction]
    Headline 
    	creates cell complex from given polyhedron 
    Usage 
    	cellComplex(Ring,Polyhedron) 
    Inputs 
    	R : Ring 
	    that specifies the base ring 
	P : Polyhedron 
    Outputs 
    	: CellComplex 
	    whose cells are the faces of the given polyhedron P
    Description 
    	Text 
	    Given a polyhedron, this command returns the cell complex whose
            cells correspond to the faces of the polyhedron. The faces have
            the default label 1.
	Example 
	    R = QQ;
	    P = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
	    faces P
	    C = cellComplex(R,P);
	    cells C
    SeeAlso
    	(cellComplex,Ring,PolyhedralComplex)
///

doc /// 
    Key 
    	(cellComplex,Ring,PolyhedralComplex)
        [(cellComplex,Ring,PolyhedralComplex),LabelFunction]
    Headline 
    	creates cell complex from given polyhedral complex 
    Usage 
    	cellComplex(Ring,PolyhedralComplex) 
    Inputs 
    	R : Ring 
	    that specifies the base ring 
        P : PolyhedralComplex 
    Outputs 
    	: CellComplex 
	    whose cells are the faces of the given polyhedral complex 
    Description 
    	Text 
	    Given a polyhedral complex, this commend returns the
            cell complex whose cells correspond to the faces of the polyhedral
            complex. The faces have the default label 1.
	Example 
	    R = QQ[x];
	    P1 = convexHull matrix {{2,2,0},{1,-1,0}};
	    P2 = convexHull matrix {{2,-2,0},{1,1,0}};
	    P3 = convexHull matrix {{-2,-2,0},{1,-1,0}};
	    P4 = convexHull matrix {{-2,2,0},{-1,-1,0}};
	    F = polyhedralComplex {P1,P2,P3,P4};
	    C = cellComplex(R,F);
	    facePoset C
        Text
            The labels on the verticies can be controlled via the optional parameter LabelFunction
            This parameter expects a function that takes a ...
    SeeAlso
    	(cellComplex,Ring,Polyhedron)
///

doc /// 
    Key 
        relabelCellComplex 
        (relabelCellComplex,CellComplex,HashTable)
	InferLabels
	[relabelCellComplex,InferLabels]
    Headline 
    	relabels a cell complex 
    Usage 
    	relabelCellComplex(C,H) 
    Inputs 
    	C : CellComplex 
	H : HashTable 
	    whose keys are cells of C and whose corresponding value is the cell's new label
    Outputs 
    	: CellComplex 
	    whose cells are relabeled by the values in the hashtable H 
    Description 
    	Text 
	    Given a cell complex C and a hashtable, whose key-value pairs
            are a cell from C and a new label for that cell, this command
            relabels C accordingly. Labels for cells not provided in the
            hashtable are inferred to be the lcm of the labels of their
            boundary cells, unless the option InferLabels is set to false.
	Example 
	    R = QQ[a,b,c];
	    P1 = convexHull matrix {{0,1,0},{0,0,1}};
	    P2 = convexHull matrix {{1,0,1},{0,1,1}};
	    P = polyhedralComplex {P1,P2};
	    C = cellComplex(R,P);
	    verts = cells(0,C);
	    v0 = verts#0;
	    v1 = verts#1;
	    v2 = verts#2;
	    v3 = verts#3;
	    T = new HashTable from {v0 => a^2*b, v1 => b*c^2, v2 => b^2, v3 => a*c};
	    relabeledC = relabelCellComplex(C,T);
	    for c in cells(0,relabeledC) list cellLabel(c)
	    for c in cells(1,relabeledC) list cellLabel(c)
    SeeAlso 
    	cellLabel
        (symbol **,RingMap,CellComplex)
///

doc /// 
    Key
	(symbol **,RingMap,CellComplex)
    Headline 
        tensors labels via a ring map
    Usage
        f ** C
    Inputs
        f : RingMap
        C : CellComplex
    Outputs
        : CellComplex
         whose cells labels are given by tensoring by the ring map f
    Description
        Text
            Given a ring map f and a cell complex C, then for each label, viewed as a module M, this function constructs a cell complex whose new labels are f ** M
    	Example 
	    S = QQ[x,y,z];
	    R = QQ[a,b,c];
	    f = map(R,S,matrix{{a,b,c^2}});
	    v1 = newCell({},x);
	    v2 = newCell({},y);
	    v3 = newCell({},z);
	    e12 = newCell({v1,v2});
	    e23 = newCell({v2,v3});
	    C = cellComplex(S,{e12,e23});
	    cells(1,C)/cellLabel
	    D = f ** C;
	    cells(1,D)/cellLabel
    SeeAlso
        relabelCellComplex
///

doc ///
    Key
        cellComplexSphere
        (cellComplexSphere,Ring,ZZ)
    Headline
        gives a sphere as a cell complex
    Usage
    	cellComplexSphere(R,n)
    Inputs
    	R : Ring
	    that specifies the base ring
	n : ZZ	    
    Outputs
    	: CellComplex
	    an n-dimensional sphere
    Description
    	Text
            This function constructs an n-dimensional sphere in the typical way for a CW-complex: a single n-dimensional cell attached to a single 0-dimensional cell.
	Example
	    S = cellComplexSphere(QQ,3)
	    cells(S)
	    chainComplex S
	    prune homology S
    SeeAlso
    	cellComplexRPn
	cellComplexTorus
///

doc ///
    Key
        cellComplexRPn
        (cellComplexRPn,Ring,ZZ)
    Headline
        gives a $RP^n$ as a cell complex
    Usage
    	cellComplexRPn(R,n)
    Inputs
    	R : Ring 
	    the coefficients for computing homology
	n : ZZ
    Outputs
    	: CellComplex
	    n-dimensional projective space as a cell complex
    Description
    	Text
	    This function constructs n-dimensional projective space as a cell complex with the typical CW-structure: 
	    a single cell of each dimension, where each r-cell is attached as a 2-sheeted covering to the (r-1)-cell.
	Example
	    QP5 = cellComplexRPn(QQ,5)
	    prune homology QP5
	    ZP6 = cellComplexRPn(ZZ,6)
	    prune homology ZP6
    SeeAlso
    	cellComplexSphere
	cellComplexTorus
///

doc ///
    Key
        cellComplexTorus
        (cellComplexTorus,Ring,ZZ)
    Headline
        gives a torus as a cell complex
    Usage
    	cellComplexTorus(R,n)
    Inputs
    	R : Ring
	n : ZZ
    Outputs
    	: CellComplex
	    the n-dimensional torus
    Description
    	Text
	    This function returns the n-dimensional torus as a cell complex in the usual way:
            the product of n copies of S^1.
	Example
	    T3 = cellComplexTorus(QQ,3)
	    cells(T3)
	    prune homology T3
    SeeAlso
    	cellComplexSphere
	cellComplexRPn
///


doc ///
    Key
        hullComplex
        (hullComplex,QQ,MonomialIdeal)
        (hullComplex,ZZ,MonomialIdeal)
        (hullComplex,MonomialIdeal)
    Headline
        gives the hull complex of a monomial ideal
    Usage 
        hullComplex I
        hullComplex(t,I)
    Inputs
        t : QQ
        t : ZZ
        I : MonomialIdeal
    Outputs 
        : CellComplex
            the hull complex of $I$ as described in Bayer-Sturmfels' ``Cellular Resolutions of Monomial Modules''
    Description
    	Text
            Given a monomial ideal $I$, this function returns the hull complex of that ideal.
            If an rational number $t$ is provided, this will set the base used in
            the exponents used to construct the polytope as described in
            ``Combinatorial Commutative Algebra.'' The resulting complex is only a
            resolution for $t\gg 0$. In particular $t > (n+1)!$ is sufficient where
            $n$ is the number of variables in the ring. If t is not provided,
            $(n+1)!+1$ will be used.
        Text
            The example given below can be found as Example 4.23 in Miller-Sturmfels'
            ``Combinatorial Commutative Algebra.''
            In this example, the resolution supported on the hull complex is minimal,
            but this is not always the case. We also see that for $t=3/2$ the resulting
            complex is no longer a resolution.
        Example
            S = QQ[x,y,z];
            I = monomialIdeal (x^2*z, x*y*z, y^2*z, x^3*y^5, x^4*y^4, x^5*y^3);
            H = hullComplex I
            chainComplex H
            cells(1,H)/cellLabel
            cells(2,H)/cellLabel
            isMinimal H
            H2 = hullComplex (3/2,I)
            prune HH chainComplex H2
    SeeAlso 
        (taylorComplex,MonomialIdeal)
///


doc ///
    Key
        taylorComplex
        (taylorComplex,MonomialIdeal)
    Headline
        gives the Taylor complex of a monomial ideal
    Usage 
    	taylorComplex I
    Inputs
    	I : MonomialIdeal
    Outputs
    	: CellComplex
	    the Taylor complex of $I$
    Description
    	Text
            Given a monomial ideal I, this function returns the Taylor complex of that ideal.
            Recall that the Taylor complex is a simplex with verticies labeled by the generators
            of the ideal.
	Example
	    S = QQ[x,y,z];
	    I = monomialIdeal (x^2, y^2, z^2);
	    T = taylorComplex I
	    C = chainComplex T
	    C.dd
    SeeAlso 
    	(hullComplex,MonomialIdeal)
///

doc ///
    Key
        scarfComplex
        (scarfComplex,MonomialIdeal)
    Headline
        gives the hull complex of a monomial ideal
    Usage
        scarfComplex I
    Inputs
        I : MonomialIdeal
    Outputs
        : CellComplex
            the scarf complex of $I$
    Description
        Text
	    Given a monomial ideal $I$, this function returns the scarf complex of that ideal.
            This complex, which is a subcomplex of the Taylor complex,
            if it is a resolution is always minimal, but it need not be a resolution
            in general
	Example
	    S = QQ[x,y,z];
	    I = monomialIdeal (x^2*z, x*y*z, y^2*z, x^3*y^5, x^4*y^4, x^5*y^3);
	    C = scarfComplex I
	    chainComplex C
	    cells(1,C)/cellLabel
	    cells(2,C)/cellLabel
	    isMinimal C
    SeeAlso
        (taylorComplex,MonomialIdeal)
        (hullComplex,MonomialIdeal)
///


doc ///
    Key
        maxCells
        (maxCells,CellComplex)
    Headline
        gives the maximal cells of a cell complex
    Usage 
    	maxCells C
    Inputs 
    	C : CellComplex
    Outputs 
    	: HashTable
	    whose keys are the dimensions of the maximal cells of C and whose respective values are a list of the maximal cells of that dimension
    Description
    	Text
	    Given a cell complex C, this function returns its maximal cells with respect to containment.
	Example
	    S = QQ[x,y,z];
	    v1 = newCell({},x);
	    v2 = newCell({},y);
	    v3 = newCell({},z);
	    e = newCell({v1,v2});
	    C = cellComplex(S,{e,v3});
	    maxCells C
    SeeAlso
    	(cells,CellComplex)
///
