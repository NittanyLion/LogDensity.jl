# my version of assert
jassert(b::Bool, s::String) = b ? nothing : throw( "Error in logdensity computation: $s" )


function isinvertibleproper(A::Matrix)      # clunky and slow, I hate it
    rank( A ) == size( A, 1 ) ? true : false
end
