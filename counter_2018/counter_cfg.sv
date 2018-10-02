class counter_cfg;
 static string testcase;
 static mailbox gen2bfm = new();
 static mailbox mon2cov = new();
 static mailbox mon2scb = new();
 static virtual interface counter_if vif;
 static virtual interface counter_rif rif;
endclass
