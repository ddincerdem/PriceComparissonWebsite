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
    
    public partial class MAGAZA
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public MAGAZA()
        {
            this.URUN = new HashSet<URUN>();
        }
    
        public int MagazaID { get; set; }
        public string MagazaAdi { get; set; }
        public string MagazaResimPath { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<URUN> URUN { get; set; }
    }
}