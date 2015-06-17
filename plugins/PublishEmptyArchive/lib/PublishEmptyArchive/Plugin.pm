package PublishEmptyArchive::Plugin;
use strict;

sub _cb_cms_pre_save_blog {
    my ( $cb, $app, $obj ) = @_;
    $obj->publish_empty_archive( $app->param( 'publish_empty_archive' ) ? 1 : 0 );
    1;
}

sub _cb_tp_cfg_prefs {
    my ( $cb, $app, $param, $tmpl ) = @_;
    if ( my $pointer_field = $tmpl->getElementById( 'preferred_archive_type' ) ) {
        my $plugin = MT->component( 'PublishEmptyArchive' );
        my $nodeset = $tmpl->createElement( 'app:setting',
                                            { id => 'publish_empty_archive', 
                                              label => $plugin->translate( 'Publish With No Entries' ) ,
                                              required => 0,
                                            },
                                          );
        my $innerHTML =<<MTML;
<__trans_section component="PublishEmptyArchive">
<input id="publish_empty_archive" type="checkbox" name="publish_empty_archive" value="1"<mt:if name="publish_empty_archive"> checked="checked"</mt:if> /> <label for="publish_empty_archive"><__trans phrase="Publish category archive without entries"></label>
</__trans_section>
MTML
        $nodeset->innerHTML( $innerHTML );
        $tmpl->insertAfter( $nodeset, $pointer_field );
        $param->{ publish_empty_archive } = $app->blog->publish_empty_archive ? 1 : 0;
    }
}

1;
