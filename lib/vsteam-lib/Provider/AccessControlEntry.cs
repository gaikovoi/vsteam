﻿using System.Management.Automation;
using vsteam_lib.Provider;

namespace vsteam_lib
{
   public class AccessControlEntry : Leaf
   {
      public long Deny { get; set; }
      public long Allow { get; set; }
      public string Descriptor { get; set; }
      public PSObject ExtendedInfo { get; set; }

      public AccessControlEntry(PSObject obj) :
         base(obj, obj.GetValue("descriptor"), obj.GetValue("descriptor"), null)
      {
         this.Deny = obj.GetValue<long>("deny");
         this.Allow = obj.GetValue<long>("allow");
         this.Descriptor = obj.GetValue("descriptor");
         this.ExtendedInfo = obj.GetValue<PSObject>("extendedInfo");
      }

      public override string ToString() => $"{this.Descriptor}: Allow={this.Allow}, Deny={this.Deny}";
   }
}