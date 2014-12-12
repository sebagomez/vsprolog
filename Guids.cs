// Guids.cs
// MUST match guids.h
using System;

namespace sebagomez.VSProlog
{
    static class GuidList
    {
        public const string guidVSProlog2010PkgString = "597a2e25-3894-49a8-845a-4425c240be1c";
        public const string guidVSProlog2010CmdSetString = "14c94615-f440-48bd-8142-e82368234cf8";

        public static readonly Guid guidVSProlog2010CmdSet = new Guid(guidVSProlog2010CmdSetString);
    };
}