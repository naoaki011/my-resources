package EditIdentifier::Plugin;
use MT::Template;
use strict;

sub _edit_template_param {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $plugin = MT->component( 'EditIdentifier' );
    my $pointer_field = ( $param->{type} eq 'index' ) ? $tmpl->getElementById( 'identifier' )
                                                      : $tmpl->getElementById( 'linked_file' );
    if (( $pointer_field )&&( MT->config->DebugMode > 0 )) {
        my $innerHTML = <<'MTML';
<__trans_section component="EditIdentifier">
<label>
    <input type="text" name="identifier" id="identifier" value="<mt:var name="identifier" escape="html">" class="mt-edit-field" />
</label>
</__trans_section>
MTML
        if ( $param->{type} eq 'index' ) {
            $pointer_field->setAttribute( 'label', $plugin->translate( 'Identifier' ) );
            $pointer_field->innerHTML( $innerHTML );
        } else {
            my $nodeset = $tmpl->createElement( 'app:setting', { id => 'identifier',
                                                                 label => $plugin->translate( 'Identifier' ),
                                                                 label_class => 'top-level',
                                                                 required => 0,
                                                               }
                                              );
            $nodeset->innerHTML( $innerHTML );
            $tmpl->insertBefore( $nodeset, $pointer_field );
        }
    }
}

1;