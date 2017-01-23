--Parasite Fusioner
--created by MLD equip effect check fixed by CC
function c511002961.initial_effect(c)
	--Fusion monster, name + name
	function aux.FConditionFilter21(c,code1,code2,sub)
		return c:IsFusionCode(code1,code2) or (sub and c:IsHasEffect(511002961))
	end
	
	function aux.FConditionCode2(code1,code2,sub,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local mg=g:Filter(Card.IsCanBeFusionMaterial,gc,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					local b1=0 local b2=0 local bw=0 local bwx=0
					if gc:IsFusionCode(code1) then b1=1 end
					if gc:IsFusionCode(code2) then b2=1 end
					if sub and gc:IsHasEffect(511002961) then bwx=1 end
					if sub and gc:CheckFusionSubstitute(e:GetHandler()) then bw=1 end
					if b1+b2+bw==0 then return false end
					if chkf~=PLAYER_NONE and not Auxiliary.FConditionCheckF(gc,chkf) then
						mg=mg:Filter(Auxiliary.FConditionCheckF,nil,chkf)
					end
					if b1+b2+bw>1 or bwx==1 then
						return mg:IsExists(Auxiliary.FConditionFilter22,1,nil,code1,code2,sub,e:GetHandler())
					elseif b1==1 then
						return mg:IsExists(Auxiliary.FConditionFilter12,1,nil,code2,sub,e:GetHandler())
					elseif b2==1 then
						return mg:IsExists(Auxiliary.FConditionFilter12,1,nil,code1,sub,e:GetHandler())
					else
						return mg:IsExists(Auxiliary.FConditionFilter21,1,nil,code1,code2,sub)
					end
				end
				local b1=0 local b2=0 local bw=0 local bwxct=0
				local ct=0
				local fs=chkf==PLAYER_NONE
				local tc=mg:GetFirst()
				while tc do
					local match=false
					if tc:IsFusionCode(code1) then b1=1 match=true end
					if tc:IsFusionCode(code2) then b2=1 match=true end
					if sub and tc:IsHasEffect(511002961) then bwxct=bwxct+1 match=true end
					if sub and not tc:IsHasEffect(511002961) and tc:CheckFusionSubstitute(e:GetHandler()) then bw=1 match=true end
					if match then
						if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
						ct=ct+1
					end
					tc=mg:GetNext()
				end
				return ct>1 and b1+b2+bw+bwxct>1 and fs
			end
	end
	function Auxiliary.FOperationCode2(code1,code2,sub,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local g=eg:Filter(Card.IsCanBeFusionMaterial,gc,e:GetHandler())
				local tc=gc
				local g1=nil
				if gc then
					if chkf~=PLAYER_NONE and not Auxiliary.FConditionCheckF(gc,chkf) then
						g=g:Filter(Auxiliary.FConditionCheckF,nil,chkf)
					end
				else
					local sg=g:Filter(Auxiliary.FConditionFilter22,nil,code1,code2,sub,e:GetHandler())
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					if chkf~=PLAYER_NONE then g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
					else g1=sg:Select(tp,1,1,nil) end
					tc=g1:GetFirst()
					g:RemoveCard(tc)
				end
				local b1=0 local b2=0 local bw=0 local bwx=0
				if tc:IsFusionCode(code1) then b1=1 end
				if tc:IsFusionCode(code2) then b2=1 end
				if sub and tc:IsHasEffect(511002961) then bwx=1 end
				if sub and not tc:IsHasEffect(511002961) and tc:CheckFusionSubstitute(e:GetHandler()) then bw=1 end
				local g2=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				if b1+b2+bw>1 or bwx==1 then
					g2=g:FilterSelect(tp,Auxiliary.FConditionFilter22,1,1,nil,code1,code2,sub,e:GetHandler())
				elseif b1==1 then
					g2=g:FilterSelect(tp,Auxiliary.FConditionFilter12,1,1,nil,code2,sub,e:GetHandler())
				elseif b2==1 then
					g2=g:FilterSelect(tp,Auxiliary.FConditionFilter12,1,1,nil,code1,sub,e:GetHandler())
				else
					g2=g:FilterSelect(tp,Auxiliary.FConditionFilter21,1,1,nil,code1,code2,sub)
				end
				if g1 then g2:Merge(g1) end
				Duel.SetFusionMaterial(g2)
			end
	end
	
	--Fusion monster, name + name + name
	function Auxiliary.FConditionFilter31(c,code1,code2,code3,sub)
		return c:IsFusionCode(code1,code2,code3) or (sub and c:IsHasEffect(511002961))
	end
	
	function Auxiliary.FConditionCode3(code1,code2,code3,sub,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					local b1=0 local b2=0 local b3=0 local bw=0 local bwxct=0 local bwg=Group.CreateGroup()
					local tc=mg:GetFirst()
					while tc do
						if sub and tc:IsHasEffect(511002961) then
							bwxct=bwxct+1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
						else
							if bwg:IsExists(c511002961.FConditionFilterCodeAndSub,1,nil,tc:GetCode(),e:GetHandler()) then
								if tc:IsFusionCode(code1) then b1=1 elseif tc:IsFusionCode(code2) then b2=1 
									elseif tc:IsFusionCode(code3) then b3=1 
								end
								bw=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								bwg:Remove(c511002961.FConditionFilterCodeAndSub,nil,tc:GetCode(),e:GetHandler())
							else
								if sub and tc:CheckFusionSubstitute(e:GetHandler()) then
									if tc:IsFusionCode(code1,code2,code3) then bwg:AddCard(tc) 
									else bw=1 end
									if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								else
									if tc:IsFusionCode(code1) then b1=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									elseif tc:IsFusionCode(code2) then b2=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									elseif tc:IsFusionCode(code3) then b3=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									end
								end
							end
						end
						tc=mg:GetNext()
					end
					local chc=bwg:GetFirst()
					while chc do
						if tc:IsFusionCode(code1) and b1==0 then b1=1
						elseif tc:IsFusionCode(code2) and b2==0 then b2=1
						elseif tc:IsFusionCode(code3) and b3==0 then b3=1
						else bw=1 end
						chc=bwg:GetNext()
					end
					if sub and gc:IsHasEffect(511002961) then
						return b1+b2+b3+bw+bwxct>1
					elseif sub and gc:CheckFusionSubstitute(e:GetHandler()) then
						return b1+b2+b3+bwxct>1
					else
						if gc:IsFusionCode(code1) and b1==0 then b1=1
						elseif gc:IsFusionCode(code2) and b2==0 then b2=1
						elseif gc:IsFusionCode(code3) and b3==0 then b3=1
						else return false
						end
						return b1+b2+b3+bw+bwxct>2
					end
				end
				local b1=0 local b2=0 local b3=0 local bs=0 local bwxct=0 local bwg=Group.CreateGroup()
				local fs=false
				local tc=mg:GetFirst()
				while tc do
					if sub and tc:IsHasEffect(511002961) then
						bwxct=bwxct+1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
					else
						if bwg:IsExists(c511002961.FConditionFilterCodeAndSub,1,nil,tc:GetCode(),e:GetHandler()) then
							if tc:IsFusionCode(code1) then b1=1 elseif tc:IsFusionCode(code2) then b2=1 
								elseif tc:IsFusionCode(code3) then b3=1 
							end
							bs=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
							bwg:Remove(c511002961.FConditionFilterCodeAndSub,nil,tc:GetCode(),e:GetHandler())
						else
							if sub and tc:CheckFusionSubstitute(e:GetHandler()) then
								if tc:IsFusionCode(code1,code2,code3) then bwg:AddCard(tc) 
								else bs=1 end
								if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
							else
								if tc:IsFusionCode(code1) then b1=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								elseif tc:IsFusionCode(code2) then b2=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								elseif tc:IsFusionCode(code3) then b3=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								end
							end
						end
					end
					tc=mg:GetNext()
				end
				local chc=bwg:GetFirst()
				while chc do
					if tc:IsFusionCode(code1) and b1==0 then b1=1
					elseif tc:IsFusionCode(code2) and b2==0 then b2=1
					elseif tc:IsFusionCode(code3) and b3==0 then b3=1
					else bs=1 end
					chc=bwg:GetNext()
				end
				return b1+b2+b3+bs+bwxct>=3 and (fs or chkf==PLAYER_NONE)
			end
	end
	function Auxiliary.FOperationCode3(code1,code2,code3,sub,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					local fusubsel=false
					local sg=g:Filter(Auxiliary.FConditionFilter32,gc,code1,code2,code3,sub,e:GetHandler())
					if gc:IsHasEffect(511002961) then
						sg:RemoveCard(gc)
					elseif gc:CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
						sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3)
						sg:RemoveCard(gc)
						fusubsel=true
					elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,gc:GetCode())
					else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,gc:GetCode(),e:GetHandler())
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g1=sg:Select(tp,1,1,nil)
					if g1:GetFirst():IsHasEffect(511002961) then
						sg:Sub(g1)
					elseif g1:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
						sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3)
						sg:Sub(g1)
						fusubsel=true
					elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g1:GetFirst():GetCode())
					else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g1:GetFirst():GetCode(),e:GetHandler())
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g2=sg:Select(tp,1,1,nil)
					g1:Merge(g2)
					Duel.SetFusionMaterial(g1)
					return
				end
				local fusubsel=false
				local sg=g:Filter(Auxiliary.FConditionFilter32,nil,code1,code2,code3,sub,e:GetHandler())
				local g1=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				if chkf~=PLAYER_NONE then g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
				else g1=sg:Select(tp,1,1,nil) end
				if g1:GetFirst():IsHasEffect(511002961) then
					sg:Sub(g1)
				elseif g1:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
					sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3)
					sg:Sub(g1)
					fusubsel=true
				elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g1:GetFirst():GetCode())
				else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g1:GetFirst():GetCode(),e:GetHandler()) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g2=sg:Select(tp,1,1,nil)
				if g2:GetFirst():IsHasEffect(511002961) then
					sg:Sub(g2)
				elseif g2:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
					sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3)
					sg:Sub(g2)
					fusubsel=true
				elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g2:GetFirst():GetCode())
				else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g2:GetFirst():GetCode(),e:GetHandler()) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g3=sg:Select(tp,1,1,nil)
				g1:Merge(g2)
				g1:Merge(g3)
				Duel.SetFusionMaterial(g1)
			end
	end

	--Fusion monster, name + name + name + name
	function Auxiliary.FConditionFilter41(c,code1,code2,code3,code4,sub)
		return c:IsFusionCode(code1,code2,code3,code4) or (sub and c:IsHasEffect(511002961))
	end
	
	function Auxiliary.FConditionCode4(code1,code2,code3,code4,sub,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					local b1=0 local b2=0 local b3=0 local b4=0 local bw=0 local bwxct=0 local bwg=Group.CreateGroup()
					local tc=mg:GetFirst()
					while tc do
						if sub and tc:IsHasEffect(511002961) then
							bwxct=bwxct+1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
						else
							if bwg:IsExists(c511002961.FConditionFilterCodeAndSub,1,nil,tc:GetCode(),e:GetHandler()) then
								if tc:IsFusionCode(code1) then b1=1 elseif tc:IsFusionCode(code2) then b2=1 
									elseif tc:IsFusionCode(code3) then b3=1 elseif tc:IsFusionCode(code4) then b4=1 
								end
								bw=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								bwg:Remove(c511002961.FConditionFilterCodeAndSub,nil,tc:GetCode(),e:GetHandler())
							else
								if sub and tc:CheckFusionSubstitute(e:GetHandler()) then
									if tc:IsFusionCode(code1,code2,code3,code4) then bwg:AddCard(tc) 
									else bw=1 end
									if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								else
									if tc:IsFusionCode(code1) then b1=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									elseif tc:IsFusionCode(code2) then b2=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									elseif tc:IsFusionCode(code3) then b3=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									elseif tc:IsFusionCode(code4) then b4=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
									end
								end
							end
						end
						tc=mg:GetNext()
					end
					local chc=bwg:GetFirst()
					while chc do
						if tc:IsFusionCode(code1) and b1==0 then b1=1
						elseif tc:IsFusionCode(code2) and b2==0 then b2=1
						elseif tc:IsFusionCode(code3) and b3==0 then b3=1
						elseif tc:IsFusionCode(code4) and b4==0 then b4=1
						else bs=1 end
						chc=bwg:GetNext()
					end
					if sub and gc:IsHasEffect(511002961) then
						return b1+b2+b3+b4+bw+bwxct>2
					elseif sub and gc:CheckFusionSubstitute(e:GetHandler()) then
						return b1+b2+b3+b4+bwxct>2
					else
						if gc:IsFusionCode(code1) and b1==0 then b1=1
						elseif gc:IsFusionCode(code2) and b2==0 then b2=1
						elseif gc:IsFusionCode(code3) and b3==0 then b3=1
						elseif gc:IsFusionCode(code4) and b4==0 then b4=1
						else return false
						end
						return b1+b2+b3+b4+bw+bwxct>3
					end
				end
				local b1=0 local b2=0 local b3=0 local b4=0 local bs=0 local bwxct=0 local bwg=Group.CreateGroup()
				local fs=false
				local tc=mg:GetFirst()
				while tc do
					if sub and tc:IsHasEffect(511002961) then
						bwxct=bwxct+1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
					else
						if bwg:IsExists(c511002961.FConditionFilterCodeAndSub,1,nil,tc:GetCode(),e:GetHandler()) then
							if tc:IsFusionCode(code1) then b1=1 elseif tc:IsFusionCode(code2) then b2=1 
								elseif tc:IsFusionCode(code3) then b3=1 elseif tc:IsFusionCode(code4) then b4=1 
							end
							bs=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
							bwg:Remove(c511002961.FConditionFilterCodeAndSub,nil,tc:GetCode(),e:GetHandler())
						else
							if sub and tc:CheckFusionSubstitute(e:GetHandler()) then
								if tc:IsFusionCode(code1,code2,code3,code4) then bwg:AddCard(tc) 
								else bs=1 end
								if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
							else
								if tc:IsFusionCode(code1) then b1=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								elseif tc:IsFusionCode(code2) then b2=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								elseif tc:IsFusionCode(code3) then b3=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								elseif tc:IsFusionCode(code4) then b4=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
								end
							end
						end
					end
					tc=mg:GetNext()
				end
				local chc=bwg:GetFirst()
				while chc do
					if tc:IsFusionCode(code1) and b1==0 then b1=1
					elseif tc:IsFusionCode(code2) and b2==0 then b2=1
					elseif tc:IsFusionCode(code3) and b3==0 then b3=1
					elseif tc:IsFusionCode(code4) and b4==0 then b4=1
					else bs=1 end
					chc=bwg:GetNext()
				end
				return b1+b2+b3+b4+bs+bwxct>=4 and (fs or chkf==PLAYER_NONE)
			end
	end
	function Auxiliary.FOperationCode4(code1,code2,code3,code4,sub,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					local fusubsel=false
					local sg=g:Filter(Auxiliary.FConditionFilter42,gc,code1,code2,code3,code4,sub,e:GetHandler())
					if gc:IsHasEffect(511002961) then
						sg:RemoveCard(gc)
					elseif gc:CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
						sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3,code4)
						sg:RemoveCard(gc)
						fusubsel=true
					elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,gc:GetCode())
					else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,gc:GetCode(),e:GetHandler())
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g1=sg:Select(tp,1,1,nil)
					if g1:GetFirst():IsHasEffect(511002961) then
						sg:Sub(g1)
					elseif g1:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
						sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3,code4)
						sg:Sub(g1)
						fusubsel=true
					elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g1:GetFirst():GetCode())
					else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g1:GetFirst():GetCode(),e:GetHandler())
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g2=sg:Select(tp,1,1,nil)
					if g2:GetFirst():IsHasEffect(511002961) then
						sg:Sub(g2)
					elseif g2:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
						sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3,code4)
						sg:Sub(g2)
						fusubsel=true
					elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g1:GetFirst():GetCode())
					else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g1:GetFirst():GetCode(),e:GetHandler())
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g3=sg:Select(tp,1,1,nil)
					g1:Merge(g2)
					g1:Merge(g3)
					Duel.SetFusionMaterial(g1)
					return
				end
				local fusubsel=false
				local sg=g:Filter(Auxiliary.FConditionFilter42,nil,code1,code2,code3,code4,sub,e:GetHandler())
				local g1=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				if chkf~=PLAYER_NONE then g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
				else g1=sg:Select(tp,1,1,nil) end
				if g1:GetFirst():IsHasEffect(511002961) then
					sg:Sub(g1)
				elseif g1:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
					sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3,code4)
					sg:Sub(g1)
					fusubsel=true
				elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g1:GetFirst():GetCode())
				else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g1:GetFirst():GetCode(),e:GetHandler()) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g2=sg:Select(tp,1,1,nil)
				if g2:GetFirst():IsHasEffect(511002961) then
					sg:Sub(g2)
				elseif g2:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
					sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3,code4)
					sg:Sub(g2)
					fusubsel=true
				elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g2:GetFirst():GetCode())
				else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g2:GetFirst():GetCode(),e:GetHandler()) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g3=sg:Select(tp,1,1,nil)
				if g3:GetFirst():IsHasEffect(511002961) then
					sg:Sub(g3)
				elseif g3:GetFirst():CheckFusionSubstitute(e:GetHandler()) and not fusubsel then
					sg:Remove(c511002961.FConditionFilterx,nil,e:GetHandler(),code1,code2,code3,code4)
					sg:Sub(g3)
					fusubsel=true
				elseif fusubsel then sg:Remove(Card.IsFusionCode,nil,g3:GetFirst():GetCode())
				else sg:Remove(c511002961.FConditionFilterCodeNotSub,nil,g3:GetFirst():GetCode(),e:GetHandler()) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g4=sg:Select(tp,1,1,nil)
				g1:Merge(g2)
				g1:Merge(g3)
				g1:Merge(g4)
				Duel.SetFusionMaterial(g1)
			end
	end
	
	--Fusion monster, name + condition
	function Auxiliary.FConditionCodeFun(code,f,cc,sub,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					if (gc:IsFusionCode(code) or (sub and gc:CheckFusionSubstitute(e:GetHandler()))) 
						and mg:IsExists(c511002961.FConditionFilterConAndSub,cc,gc,f,sub) then
						return true
					elseif f(gc) or (sub and gc:IsHasEffect(511002961)) then
						local g1=Group.CreateGroup() local g2=Group.CreateGroup()
						local tc=mg:GetFirst()
						while tc do
							if tc:IsFusionCode(code) or (sub and tc:CheckFusionSubstitute(e:GetHandler()))
								then g1:AddCard(tc) end
							if f(tc) or (sub and tc:IsHasEffect(511002961)) then g2:AddCard(tc) end
							tc=mg:GetNext()
						end
						if cc>1 then
							g2:RemoveCard(gc)
							return g1:IsExists(Auxiliary.FConditionFilterCF,1,gc,g2,cc-1)
						else
							g1:RemoveCard(gc)
							return g1:GetCount()>0
						end
					else return false end
				end
				local b1=0 local b2=0 local bw=0
				local fs=false
				local tc=mg:GetFirst()
				while tc do
					local c1=tc:IsFusionCode(code) or (sub and tc:CheckFusionSubstitute(e:GetHandler()))
					local c2=f(tc) or (sub and tc:IsHasEffect(511002961))
					if c1 or c2 then
						if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
						if c1 and c2 then bw=bw+1
						elseif c1 then b1=1
						else b2=b2+1
						end
					end
					tc=mg:GetNext()
				end
				if b2>cc then b2=cc end
				return b1+b2+bw>=1+cc and (fs or chkf==PLAYER_NONE)
			end
	end
	function Auxiliary.FOperationCodeFun(code,f,cc,sub,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if (gc:IsFusionCode(code) or (sub and gc:CheckFusionSubstitute(e:GetHandler()))) 
						and g:IsExists(c511002961.FConditionFilterConAndSub,cc,gc,f,sub) then
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local g1=g:FilterSelect(tp,c511002961.FConditionFilterConAndSub,cc,cc,gc,f,sub)
						Duel.SetFusionMaterial(g1)
					else
						local sg1=Group.CreateGroup() local sg2=Group.CreateGroup()
						local tc=g:GetFirst()
						while tc do
							if tc:IsFusionCode(code) or (sub and tc:CheckFusionSubstitute(e:GetHandler())) then sg1:AddCard(tc) end
							if f(tc) or (sub and tc:IsHasEffect(511002961)) then sg2:AddCard(tc) end
							tc=g:GetNext()
						end
						if cc>1 then
							sg2:RemoveCard(gc)
							if sg2:GetCount()==cc-1 then
								sg1:Sub(sg2)
							end
							Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
							local g1=sg1:Select(tp,1,1,gc)
							Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
							local g2=sg2:Select(tp,cc-1,cc-1,g1:GetFirst())
							g1:Merge(g2)
							Duel.SetFusionMaterial(g1)
						else
							Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
							local g1=sg1:Select(tp,1,1,gc)
							Duel.SetFusionMaterial(g1)
						end
					end
					return
				end
				local sg1=Group.CreateGroup() local sg2=Group.CreateGroup() local fs=false
				local tc=g:GetFirst()
				while tc do
					if tc:IsFusionCode(code) or (sub and tc:CheckFusionSubstitute(e:GetHandler())) then sg1:AddCard(tc) end
					if f(tc) or (sub and tc:IsHasEffect(511002961)) then sg2:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
					tc=g:GetNext()
				end
				if chkf~=PLAYER_NONE then
					if sg2:GetCount()==cc then
						sg1:Sub(sg2)
					end
					local g1=nil
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					if fs then g1=sg1:Select(tp,1,1,nil)
					else g1=sg1:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf) end
					local tc1=g1:GetFirst()
					sg2:RemoveCard(tc1)
					if Auxiliary.FConditionCheckF(tc1,chkf) or sg2:GetCount()==cc then
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local g2=sg2:Select(tp,cc,cc,tc1)
						g1:Merge(g2)
					else
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local g2=sg2:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,tc1,chkf)
						g1:Merge(g2)
						if cc>1 then
							sg2:RemoveCard(g2:GetFirst())
							Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
							g2=sg2:Select(tp,cc-1,cc-1,tc1)
							g1:Merge(g2)
						end
					end
					Duel.SetFusionMaterial(g1)
				else
					if sg2:GetCount()==cc then
						sg1:Sub(sg2)
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g1=sg1:Select(tp,1,1,nil)
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					g1:Merge(sg2:Select(tp,cc,cc,g1:GetFirst()))
					Duel.SetFusionMaterial(g1)
				end
			end
	end
	
	--Fusion monster, condition + condition
	function Auxiliary.FConditionFilterF2c(c,f1,f2)
		return f1(c) or f2(c) or c:IsHasEffect(511002961)
	end
	function Auxiliary.FConditionFilterF2r(c,f1,f2)
		return f1(c) and not f2(c) and not c:IsHasEffect(511002961)
	end
	
	function Auxiliary.FConditionFun2(f1,f2,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					return ((f1(gc) or gc:IsHasEffect(511002961)) and mg:IsExists(c511002961.FConditionFilterConAndSub,1,gc,f2,true))
						or ((f2(gc) or gc:IsHasEffect(511002961)) and mg:IsExists(c511002961.FConditionFilterConAndSub,1,gc,f1,true)) end
				local g1=Group.CreateGroup() local g2=Group.CreateGroup() local fs=false
				local tc=mg:GetFirst()
				while tc do
					if f1(tc) or tc:IsHasEffect(511002961) then g1:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
					if f2(tc) or tc:IsHasEffect(511002961) then g2:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
					tc=mg:GetNext()
				end
				if chkf~=PLAYER_NONE then
					return fs and g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2)
				else return g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2) end
			end
	end
	function Auxiliary.FOperationFun2(f1,f2,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					local sg=Group.CreateGroup()
					if f1(gc) or gc:IsHasEffect(511002961) then sg:Merge(g:Filter(c511002961.FConditionFilterConAndSub,gc,f2,true)) end
					if f2(gc) or gc:IsHasEffect(511002961) then sg:Merge(g:Filter(c511002961.FConditionFilterConAndSub,gc,f1,true)) end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g1=sg:Select(tp,1,1,nil)
					Duel.SetFusionMaterial(g1)
					return
				end
				local sg=g:Filter(Auxiliary.FConditionFilterF2c,nil,f1,f2)
				local g1=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				if chkf~=PLAYER_NONE then
					g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
				else g1=sg:Select(tp,1,1,nil) end
				local tc1=g1:GetFirst()
				sg:RemoveCard(tc1)
				local b1=f1(tc1) or tc1:IsHasEffect(511002961)
				local b2=f2(tc1) or tc1:IsHasEffect(511002961)
				if b1 and not b2 then sg:Remove(Auxiliary.FConditionFilterF2r,nil,f1,f2) end
				if b2 and not b1 then sg:Remove(Auxiliary.FConditionFilterF2r,nil,f2,f1) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g2=sg:Select(tp,1,1,nil)
				g1:Merge(g2)
				Duel.SetFusionMaterial(g1)
			end
	end
	--Fusion monster, name * n
	function Auxiliary.FConditionCodeRep(code,cc,sub,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					local bwxct=mg:FilterCount(c511002961.FConditionFilterx3,gc,e:GetHandler(),sub)
					local bw=0
					local ct=mg:FilterCount(c511002961.FConditionFilterCodeNotSub,gc,code,e:GetHandler())
					if mg:IsExists(c511002961.FConditionFilterx2,1,gc,e:GetHandler(),sub) then bw=1 end
					if gc:IsFusionCode(code) or (sub and gc:IsHasEffect(511002961)) then return bwxct+bw+ct>=cc-1
					elseif sub and gc:CheckFusionSubstitute(e:GetHandler()) then return bwxct+ct>=cc-1
					else return false end
				end
				local g1=mg:Filter(Card.IsFusionCode,nil,code)
				if not sub then
					if chkf~=PLAYER_NONE then return g1:GetCount()>=cc and g1:FilterCount(Card.IsOnField,nil)~=0
					else return g1:GetCount()>=cc end
				end
				g1=g1:Filter(c511002961.FConditionFilterCodeNotSub,nil,code,e:GetHandler())
				local g2=mg:Filter(c511002961.FConditionFilterx2,nil,e:GetHandler(),sub)
				local g3=mg:Filter(c511002961.FConditionFilterx3,nil,e:GetHandler(),sub)
				g1:Merge(g3)
				if chkf~=PLAYER_NONE then
					return (g1:FilterCount(Card.IsOnField,nil)~=0 or g2:FilterCount(Card.IsOnField,nil)~=0)
						and g1:GetCount()>=cc-1 and g1:GetCount()+g2:GetCount()>=cc
				else return g1:GetCount()>=cc-1 and g1:GetCount()+g2:GetCount()>=cc end
			end
	end
	function Auxiliary.FOperationCodeRep(code,cc,sub,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local notfusion=bit.rshift(chkfnf,8)~=0
				local sub=sub or notfusion
				local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					local g1=g:Filter(c511002961.FConditionFilterCodeNotSub,gc,code,e:GetHandler())
					local g3=g:Filter(c511002961.FConditionFilterx3,gc,e:GetHandler(),sub)
					g1:Merge(g3)
					if sub and gc:CheckFusionSubstitute(e:GetHandler()) and not gc:IsHasEffect(511002961) then
						if cc-1>0 then
							Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
							local mat=g1:Select(tp,cc-1,cc-1,nil)
							Duel.SetFusionMaterial(mat)
						end
					else
						if cc-1>0 then
							local sg=g:Filter(Auxiliary.FConditionFilterCR,nil,code,sub,e:GetHandler())
							local mat=Group.CreateGroup()
							local tc1
							for i=1,cc-1 do
								Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
								local mat2=sg:Select(tp,1,1,nil)
								tc1=mat2:GetFirst()
								mat:Merge(mat2)
								if tc1:CheckFusionSubstitute(e:GetHandler()) and not tc1:IsHasEffect(511002961) then 
									sg:Remove(c511002961.FConditionFilterx2,nil,e:GetHandler(),sub)
								else sg:RemoveCard(tc1) end
							end
							Duel.SetFusionMaterial(mat)
						end
					end
					return
				end
				local sg=g:Filter(Auxiliary.FConditionFilterCR,nil,code,sub,e:GetHandler())
				local g1=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				if chkf~=PLAYER_NONE then g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
				else g1=sg:Select(tp,1,1,nil) end
				local tc1=g1:GetFirst()
				for i=1,cc-1 do
					if tc1:CheckFusionSubstitute(e:GetHandler()) and not tc1:IsHasEffect(511002961) then 
						sg:Remove(c511002961.FConditionFilterx2,nil,e:GetHandler(),sub)
					else sg:RemoveCard(tc1) end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g2=sg:Select(tp,1,1,nil)
					tc1=g2:GetFirst()
					g1:Merge(g2)
				end
				Duel.SetFusionMaterial(g1)
			end
	end
	
	--Fusion monster, condition * n
	function Auxiliary.FConditionFunRep(f,cc,insf)
	return	function(e,g,gc,chkfnf)
				if g==nil then return insf end
				local chkf=bit.band(chkfnf,0xff)
				local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
					return (f(gc) or gc:IsHasEffect(511002961)) and mg:IsExists(c511002961.FConditionFilterConAndSub,cc-1,gc,f,true) end
				local g1=mg:Filter(c511002961.FConditionFilterConAndSub,nil,f,true)
				if chkf~=PLAYER_NONE then
					return g1:FilterCount(Card.IsOnField,nil)~=0 and g1:GetCount()>=cc
				else return g1:GetCount()>=cc end
			end
	end
	function Auxiliary.FOperationFunRep(f,cc,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
				local chkf=bit.band(chkfnf,0xff)
				local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
				if gc then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g1=g:FilterSelect(tp,c511002961.FConditionFilterConAndSub,cc-1,cc-1,gc,f,true)
					Duel.SetFusionMaterial(g1)
					return
				end
				local sg=g:Filter(c511002961.FConditionFilterConAndSub,nil,f,true)
				if chkf==PLAYER_NONE or sg:GetCount()==cc then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g1=sg:Select(tp,cc,cc,nil)
					Duel.SetFusionMaterial(g1)
					return
				end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
				if cc>1 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local g2=sg:Select(tp,cc-1,cc-1,g1:GetFirst())
					g1:Merge(g2)
				end
				Duel.SetFusionMaterial(g1)
			end
	end
	
	--Fusion monster, condition1 + condition2 * minc to maxc
	--Fusion monster, name + condition * minc to maxc
	function Auxiliary.FConditionFilterFFR(c,f1,f2,mg,minc,chkf)
		if not f1(c) and not c:IsHasEffect(511002961) then return false end
		if chkf==PLAYER_NONE or aux.FConditionCheckF(c,chkf) then
			return minc<=0 or mg:IsExists(c511002961.FConditionFilterConAndSub,minc,c,f2,true)
		else
			local mg2=mg:Filter(c511002961.FConditionFilterConAndSub,c,f2,true)
			return mg2:GetCount()>=minc and mg2:IsExists(aux.FConditionCheckF,1,nil,chkf)
		end
	end

	function Auxiliary.FConditionFunFunRep(f1,f2,minc,maxc,insf)
	return	function(e,g,gc,chkfnf)
			if g==nil then return insf end
			local chkf=bit.band(chkfnf,0xff)
			local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
			if gc then
				if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
				if aux.FConditionFilterFFR(gc,f1,f2,mg,minc,chkf) then
					return true
				elseif f2(gc) or gc:IsHasEffect(511002961) then
					mg:RemoveCard(gc)
					if aux.FConditionCheckF(gc,chkf) then chkf=PLAYER_NONE end
					return mg:IsExists(aux.FConditionFilterFFR,1,nil,f1,f2,mg,minc-1,chkf)
				else return false end
			end
			return mg:IsExists(aux.FConditionFilterFFR,1,nil,f1,f2,mg,minc,chkf)
		end
	end
	function Auxiliary.FOperationFunFunRep(f1,f2,minc,maxc,insf)
	return	function(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
			local chkf=bit.band(chkfnf,0xff)
			local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
			local minct=minc
			local maxct=maxc
			if gc then
				g:RemoveCard(gc)
				if aux.FConditionFilterFFR(gc,f1,f2,g,minct,chkf) then
					if aux.FConditionCheckF(gc,chkf) then chkf=PLAYER_NONE end
					local g1=Group.CreateGroup()
					if f2(gc) or gc:IsHasEffect(511002961) then
						local mg1=g:Filter(aux.FConditionFilterFFR,nil,f1,f2,g,minct-1,chkf)
						if mg1:GetCount()>0 then
							--if gc fits both, should allow an extra material that fits f1 but doesn't fit f2
							local mg2=g:Filter(c511002961.FConditionFilterConAndSub,nil,f2,true)
							mg1:Merge(mg2)
							if chkf~=PLAYER_NONE then
								Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
								local sg=mg1:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
								g1:Merge(sg)
								mg1:Sub(sg)
								minct=minct-1
								maxct=maxct-1
								if not f2(sg:GetFirst()) and not sg:GetFirst():IsHasEffect(511002961) then
									if mg1:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
										if minct<=0 then minct=1 end
										Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
										local sg=mg1:FilterSelect(tp,c511002961.FConditionFilterConAndSub,minct,maxct,nil,f2,true)
										g1:Merge(sg)
									end
									Duel.SetFusionMaterial(g1)
									return
								end
							end
							if maxct>1 and (minct>1 or Duel.SelectYesNo(tp,93)) then
								Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
								local sg=mg1:FilterSelect(tp,c511002961.FConditionFilterConAndSub,minct-1,maxct-1,nil,f2,true)
								g1:Merge(sg)
								mg1:Sub(sg)
								local ct=sg:GetCount()
								minct=minct-ct
								maxct=maxct-ct
							end
							Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
							local sg=mg1:Select(tp,1,1,nil)
							g1:Merge(sg)
							mg1:Sub(sg)
							minct=minct-1
							maxct=maxct-1
							if mg1:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
								if minct<=0 then minct=1 end
								Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
								local sg=mg1:FilterSelect(tp,c511002961.FConditionFilterConAndSub,minct,maxct,nil,f2,true)
								g1:Merge(sg)
							end
							Duel.SetFusionMaterial(g1)
							return
						end
					end
					local mg=g:Filter(c511002961.FConditionFilterConAndSub,nil,f2,true)
					if chkf~=PLAYER_NONE then
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local sg=mg:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
						g1:Merge(sg)
						mg:Sub(sg)
						minct=minct-1
						maxct=maxct-1
					end
					if mg:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
						if minct<=0 then minct=1 end
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local sg=mg:Select(tp,minct,maxct,nil)
						g1:Merge(sg)
					end
					Duel.SetFusionMaterial(g1)
					return
				else
					if aux.FConditionCheckF(gc,chkf) then chkf=PLAYER_NONE end
					minct=minct-1
					maxct=maxct-1
				end
			end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local g1=g:FilterSelect(tp,aux.FConditionFilterFFR,1,1,nil,f1,f2,g,minct,chkf)
			local mg=g:Filter(c511002961.FConditionFilterConAndSub,g1:GetFirst(),f2,true)
			if chkf~=PLAYER_NONE and not aux.FConditionCheckF(g1:GetFirst(),chkf) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg=mg:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
				g1:Merge(sg)
				mg:Sub(sg)
				minct=minct-1
				maxct=maxct-1
			end
			if mg:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
				if minct<=0 then minct=1 end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg=mg:Select(tp,minct,maxct,nil)
				g1:Merge(sg)
			end
			Duel.SetFusionMaterial(g1)
		end
	end

	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP+CATEGORY_FUSION_SUMMON)
	e1:SetTarget(c511002961.sptg)
	e1:SetOperation(c511002961.spop)
	c:RegisterEffect(e1)
	--fusion substitute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e2:SetCondition(c511002961.subcon)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(511002961)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_ADD_FUSION_SETCODE)
	e4:SetValue(0x9d)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(4904633)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_ADD_FUSION_SETCODE)
	e6:SetValue(0xe1)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_ADD_FUSION_SETCODE)
	e7:SetValue(0x9)
	e7:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_ADD_FUSION_SETCODE)
	e8:SetValue(0x1f)
	e8:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetCode(EFFECT_ADD_FUSION_SETCODE)
	e9:SetValue(0x8)
	e9:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e9)
	--destroy sub
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_EQUIP)
	e10:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e10:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e10:SetValue(1)
	c:RegisterEffect(e10)
	if not c511002961.global_check then
		c511002961.global_check=true
		--FUSIONZ!!!
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(c511002961.op)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002961.FConditionFilterx(c,fc,code1,code2,code3,code4)
	return c:CheckFusionSubstitute(fc) and not c:IsHasEffect(511002961) and not c:IsFusionCode(code1,code2,code3,code4)
end
function c511002961.FConditionFilterx2(c,fc,sub)
	return sub and c:CheckFusionSubstitute(fc) and not c:IsHasEffect(511002961)
end
function c511002961.FConditionFilterx3(c,fc,sub)
	return sub and c:CheckFusionSubstitute(fc) and c:IsHasEffect(511002961)
end
function c511002961.FConditionFilterCodeAndSub(c,code,fc)
	return c:IsFusionCode(code) and c:CheckFusionSubstitute(fc)
end
function c511002961.FConditionFilterCodeOrSub2(c,code1,code2)
	return c:IsFusionCode(code1,code2) or c:IsHasEffect(511002961)
end
function c511002961.FConditionFilterCodeNotSub(c,code,fc)
	return c:IsFusionCode(code) and not c:CheckFusionSubstitute(fc)
end
function c511002961.FConditionFilterConAndSub(c,f,sub)
	return f(c) or (sub and c:IsHasEffect(511002961))
end
function c511002961.op(e,tp,eg,ep,ev,re,r,rp)
	--Non-Utility Fusions
	local mt
	if c77693536 then --フルメタルフォーゼ・アルカエスト (Fullmetalfoes Alkahest)
		mt=c77693536
		mt.filter2=function(c) return c:IsType(TYPE_NORMAL) or c:IsHasEffect(511002961) end
	end
	if c54401832 then --メタルフォーゼ・カーディナル (Metalfoes Crimsonite)
		mt=c54401832
		mt.filter2=function(c) return c:IsAttackBelow(3000) or c:IsHasEffect(511002961) end
	end
	if c4688231 then --メタルフォーゼ・ミスリエル (Metalfoes Mythriel)
		mt=c4688231
		mt.filter2=function(c) return c:IsType(TYPE_PENDULUM) or c:IsHasEffect(511002961) end
	end
	if c81612598 then --メタルフォーゼ・アダマンテ (Metalfoes Adamante)
		mt=c81612598
		mt.filter2=function(c) return c:IsAttackBelow(2500) or c:IsHasEffect(511002961) end
	end
	if c74506079 then --ワーム・ゼロ (Worm Zero)
		mt=c74506079
		mt.ffilter=function(c) return (c:IsFusionSetCard(0x3e) and c:IsRace(RACE_REPTILE)) or c:IsHasEffect(511002961) end
	end
	if c82734805 then --インフェルノイド・ティエラ (Infernoid Tierra)
		mt=c82734805
		mt.fcfilter1=function(c,code1,code2,g) return (c:IsFusionCode(code1,code2) or c:IsHasEffect(511002961))
			and g:IsExists(c511002961.tierrafilter2,1,c) end
		mt.fcfilter2=function(c,code,g,fc) return (c:IsFusionCode(code) or c:CheckFusionSubstitute(fc)) and g:IsExists(c511002961.tierrafilter2,1,c) end
		mt.fcfilter3=function(c,g,fc) 
			if c:IsHasEffect(511002961) then
				return g:IsExists(c82734805.fcfilter1,1,c,14799437,23440231,g)
			elseif c:CheckFusionSubstitute(fc) then
				return g:IsExists(c511002961.FConditionFilterCodeOrSub2,1,c,14799437,23440231)
			end
			if c:IsFusionCode(14799437) and g:IsExists(c82734805.fcfilter2,1,c,23440231,g,fc) then return true end
			if c:IsFusionCode(23440231) and g:IsExists(c82734805.fcfilter2,1,c,14799437,g,fc) then return true end
			return false
		end
		mt.fscon=function(e,g,gc,chkf)
			if g==nil then return true end
			if gc then
				local mg=g:Clone()
				mg:RemoveCard(gc)
				if gc:IsHasEffect(511002961) then
					return mg:IsExists(c82734805.fcfilter3,1,nil,mg,e:GetHandler()) 
						or mg:IsExists(c511002961.tierrafilter1,1,nil,14799437,23440231,mg,e:GetHandler())
				elseif gc:CheckFusionSubstitute(e:GetHandler()) then
					return mg:IsExists(c82734805.fcfilter1,1,nil,14799437,23440231,mg)
				elseif gc:IsFusionCode(14799437) then
					return mg:IsExists(c82734805.fcfilter2,1,nil,23440231,mg,e:GetHandler())
				elseif gc:IsFusionCode(23440231) then
					return mg:IsExists(c82734805.fcfilter2,1,nil,14799437,mg,e:GetHandler())
				elseif gc:IsFusionSetCard(0xbb) then
					return mg:IsExists(c82734805.fcfilter3,1,nil,mg,e:GetHandler())
				else
					return false
				end
			end
			local b1=0 local b2=0 local b3=0 local bs=0 local bwxct=0 local bwg=Group.CreateGroup()
			local fs=false
			local tc=g:GetFirst()
			while tc do
				if tc:IsHasEffect(511002961) then
					bwxct=bwxct+1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
				else
					if bwg:IsExists(c511002961.FConditionFilterCodeAndSub,1,nil,tc:GetCode(),e:GetHandler()) then
						if tc:IsFusionCode(14799437) then 
							if b1==0 then b1=1 else b3=1 end if aux.FConditionCheckF(tc,chkf) then fs=true end
						elseif tc:IsFusionCode(23440231) then
							if b2==0 then b2=1 else b3=1 end if aux.FConditionCheckF(tc,chkf) then fs=true end
						end
						bs=1 if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
						bwg:Remove(c511002961.FConditionFilterCodeAndSub,nil,tc:GetCode(),e:GetHandler())
					else
						if tc:CheckFusionSubstitute(e:GetHandler()) then
							if tc:IsFusionCode(14799437,23440231) then bwg:AddCard(tc) 
							else bs=1 end
							if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end
						else
							if tc:IsFusionCode(14799437) then
								if b1==0 then b1=1 else b3=1 end if aux.FConditionCheckF(tc,chkf) then fs=true end
							elseif tc:IsFusionCode(23440231) then
								if b2==0 then b2=1 else b3=1 end if aux.FConditionCheckF(tc,chkf) then fs=true end
							end
						end
					end
				end
				tc=g:GetNext()
			end
			local chc=bwg:GetFirst()
			while chc do
				if tc:IsFusionCode(14799437) then 
					if b1==0 then b1=1 
					elseif bs==0 then bs=1 
					else b3=1 end
				else
					if b2==0 then b2=1 
					elseif bs==0 then bs=1 
					else b3=1 end
				end
				chc=bwg:GetNext()
			end
			if chkf~=PLAYER_NONE then
				return fs and b1+b2+b3+bs+bwxct>=3
			else
				return b1+b2+b3+bs+bwxct>=3
			end
		end
		mt.fsop=function(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
			local g1=Group.CreateGroup()
			if not gc and chkf~=PLAYER_NONE then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				gc=eg:FilterSelect(tp,c82734805.fcfilter7,1,1,nil,chkf,e:GetHandler()):GetFirst()
				g1:AddCard(gc)
			end
			local mg=eg:Clone()
			if gc then mg:RemoveCard(gc) end
			local ok=false
			if gc then
				if gc:IsHasEffect(511002961) and mg:IsExists(c511002961.tierrafilter1,1,nil,14799437,23440231,mg,e:GetHandler()) 
					and (not mg:IsExists(c82734805.fcfilter3,1,nil,mg,e:GetHandler()) or Duel.SelectYesNo(tp,93)) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local sg=mg:FilterSelect(tp,c511002961.tierrafilter1,1,1,nil,14799437,23440231,mg,e:GetHandler())
					g1:Merge(sg)
				elseif gc:CheckFusionSubstitute(e:GetHandler()) and not gc:IsHasEffect(511002961) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local sg=mg:FilterSelect(tp,c82734805.fcfilter1,1,1,nil,14799437,23440231,mg)
					g1:Merge(sg)
				elseif gc:IsFusionCode(14799437) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local sg=mg:FilterSelect(tp,c82734805.fcfilter2,1,1,nil,23440231,mg,e:GetHandler())
					g1:Merge(sg)
				elseif gc:IsFusionCode(23440231) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local sg=mg:FilterSelect(tp,c82734805.fcfilter2,1,1,nil,14799437,mg,e:GetHandler())
					g1:Merge(sg)
				elseif gc:IsFusionSetCard(0xbb) or gc:IsHasEffect(511002961) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local sg=mg:FilterSelect(tp,c82734805.fcfilter3,1,1,nil,mg,e:GetHandler())
					g1:Merge(sg)
					local tc1=sg:GetFirst()
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					if tc1:IsHasEffect(511002961) then
						local sg=mg:FilterSelect(tp,aux.FConditionFilter22,1,1,nil,14799437,23440231,true,e:GetHandler())
						g1:Merge(sg)
					elseif tc1:IsFusionCode(14799437) then
						local sg=mg:FilterSelect(tp,c82734805.fcfilter4,1,1,nil,23440231,e:GetHandler())
						g1:Merge(sg)
					elseif tc1:IsFusionCode(23440231) then
						local sg=mg:FilterSelect(tp,c82734805.fcfilter4,1,1,nil,14799437,e:GetHandler())
						g1:Merge(sg)
					else
						local sg=mg:FilterSelect(tp,aux.FConditionFilter21,1,1,nil,14799437,23440231)
						g1:Merge(sg)
					end
					ok=true
				end
			else
				local mg2=mg:Filter(aux.FConditionFilter22,nil,14799437,23440231,true,e:GetHandler())
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg1=mg2:Select(tp,1,1,nil)
				local tc1=sg1:GetFirst()
				if not mg:IsExists(c511002961.tierrafilter2,2,tc1) then
					mg2:Remove(c511002961.tierrafilter2,nil)
				end
				if tc1:CheckFusionSubstitute(e:GetHandler()) and not tc1:IsHasEffect(511002961) then
					mg2:Remove(c511002961.FConditionFilterx2,nil,e:GetHandler(),true)
				elseif tc1:IsHasEffect(511002961) then
				else mg2:Remove(Card.IsFusionCode,nil,tc1:GetCode()) end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg2=mg2:Select(tp,1,1,tc1)
				g1:Merge(sg1)
				g1:Merge(sg2)
			end
			mg:Sub(g1)
			mg=mg:Filter(c511002961.tierrafilter2,nil)
			if mg:GetCount()==0 or (ok and not Duel.SelectYesNo(tp,93)) then
				Duel.SetFusionMaterial(g1)
				return
			end
			ok=false
			local dmg=mg:Filter(Card.IsLocation,nil,LOCATION_DECK)
			if dmg:GetCount()>0 and e:GetHandler():GetFlagEffect(31444249)~=0 and Duel.SelectYesNo(tp,aux.Stringid(31444249,0)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg=dmg:Select(tp,1,6-g1:FilterCount(Card.IsLocation,nil,LOCATION_DECK),nil)
				g1:Merge(sg)
				ok=true
			end
			if e:GetHandler():GetFlagEffect(31444249)~=0 then
				mg:Remove(Card.IsLocation,nil,LOCATION_DECK)
			end
			if mg:GetCount()==0 or (ok and not Duel.SelectYesNo(tp,93)) then
				Duel.SetFusionMaterial(g1)
				return
			end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local sg=mg:Select(tp,1,99,nil)
			g1:Merge(sg)
			Duel.SetFusionMaterial(g1)
			return
		end
		
		local sg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil,82734805)
		local tcc=sg:GetFirst()
		while tcc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_FUSION_MATERIAL)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_REPEAT)
			if c82734805 then
				e1:SetCondition(c82734805.fscon)
				e1:SetOperation(c82734805.fsop)
			end
			tcc:RegisterEffect(e1)
			tcc=sg:GetNext()
		end
	end
end
function c511002961.tierrafilter1(c,code1,code2,g,fc)
	return (c:IsFusionCode(code1,code2) or c:CheckFusionSubstitute(fc)) and g:IsExists(c511002961.tierrafilter2,1,c)
end
function c511002961.tierrafilter2(c)
	return c:IsFusionSetCard(0xbb) or c:IsHasEffect(511002961)
end

function c511002961.subcon(e)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsOnField()
end
function c511002961.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511002961.filter2(c,e,tp,m,f,gc)
	return c:IsType(TYPE_FUSION) and (not f or f(c)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
		and c:CheckFusionMaterial(m,gc)
end
function c511002961.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_MZONE+LOCATION_HAND,0,c)
		local res=Duel.IsExistingMatchingCard(c511002961.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,c)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511002961.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,c)
			end
		end
		return res and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002961.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) then return end
	local mg1=Duel.GetMatchingGroup(c511002961.filter1,tp,LOCATION_MZONE+LOCATION_HAND,0,c,e)
	local sg1=Duel.GetMatchingGroup(c511002961.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,c)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511002961.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,c)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,c)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,c)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.BreakEffect()
		if not Duel.Equip(tp,c,tc,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511002961.eqlimit)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	end
end
function c511002961.eqlimit(e,c)
	return e:GetLabelObject()==c
end

