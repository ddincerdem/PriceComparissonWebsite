//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MiniWave.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class KATEGORİ
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KATEGORİ()
        {
            this.ALT_KATEGORİ = new HashSet<ALT_KATEGORİ>();
        }
    
        public int KategoriID { get; set; }
        public string KategoriAdı { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ALT_KATEGORİ> ALT_KATEGORİ { get; set; }
    }
}
