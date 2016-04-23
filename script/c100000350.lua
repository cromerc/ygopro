--氷炎の世界
function c100000350.initial_effect(c)
function Auxiliary.AddXyzProcedure(c,f,ct,alterf,desc,maxct,op)
	if c.xyz_filter==nil then
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		mt.xyz_filter=f
		mt.xyz_count=ct
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	if not maxct then maxct=ct end
	if alterf then
		e1:SetCondition(Auxiliary.XyzCondition2(f,ct,maxct,alterf,desc))
		e1:SetOperation(Auxiliary.XyzOperation2(f,ct,maxct,alterf,desc,op))
	else
		e1:SetCondition(Auxiliary.XyzCondition(f,ct,maxct))
		e1:SetOperation(Auxiliary.XyzOperation(f,ct,maxct))
	end
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
function Auxiliary.XyzCondition(f,minc,maxc)
	--og: use special material
return	function(e,c,og)
				if c==nil then return true end
				local ft=Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)
				local ct=-ft
				local mt=Duel.GetFieldGroup(Duel.GetTurnPlayer(),LOCATION_MZONE,nil):Filter(Card.IsHasEffect,nil,100000350)
	 			if mt:GetCount()>0 then
					local m=minc-mt:GetCount()
					if m<=ct and minc>mt:GetCount() then return false end
					if og then
						return og:IsExists(f,minc,nil)
					else
						local ms=mt:GetFirst()
						local g=Duel.GetXyzMaterial(c)
						while ms do
							if c:GetRank()==ms:GetLevel() and c:IsAttribute(ATTRIBUTE_WATER) then							
								if m>0 then 
								return g:IsExists(f,m,nil)
								else
								return g:IsExists(f,1,nil)
								end
							else
								return g:IsExists(f,minc,nil)
							end	
							ms=mt:GetNext()
						end						
					end						
				else
					if minc<=ct then return false end
					if og then
						return og:IsExists(f,minc,nil)
					else
						local g=Duel.GetXyzMaterial(c)
						return g:IsExists(f,minc,nil)
					end
				end
			end			
end
function Auxiliary.XyzOperation(f,minc,maxc)
return	function(e,tp,eg,ep,ev,re,r,rp,c,og)
				if og then
					c:SetMaterial(og)
					Duel.Overlay(c,og)
				else
					local g=Duel.GetXyzMaterial(c)
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
					local mt=Duel.GetFieldGroup(Duel.GetTurnPlayer(),LOCATION_MZONE,nil):Filter(Card.IsHasEffect,nil,100000350)
					if mt:GetCount()>0 and c:IsAttribute(ATTRIBUTE_WATER)  then
						local mp=mt:Filter(Card.GetLevel,nil,c:GetRank()):GetCount()
						if g:FilterCount(f,nil)==minc-mp then					
							local mg=g:Filter(f,nil):FilterSelect(tp,Card.IsHasEffect,mp,mp,nil,100000350)
							if minc-(mp*2)>0 then
								local mg2=g:FilterSelect(tp,f,minc-(mp*2),maxc,mg:GetFirst())
								mg:Merge(mg2)
							end										
							c:SetMaterial(mg)	
							Duel.Overlay(c,mg)
						else if g:FilterCount(f,nil)>minc-mp and mp>0 then
							local mpt=mt:Filter(Card.GetLevel,nil,c:GetRank()):GetFirst()
							local mg=Group.CreateGroup()
							if mpt then
								if Duel.SelectYesNo(tp,aux.Stringid(100000350,0)) then
									mg:AddCard(mpt)
								end
								mpt=mt:Filter(Card.GetLevel,nil,c:GetRank()):GetNext()
								if mg and minc-1>mp and mpt and Duel.SelectYesNo(tp,aux.Stringid(100000350,0)) then
									mg:AddCard(mpt)
									if minc>mg:GetCount()*2 then
										local mg2=g:FilterSelect(tp,f,minc-4,maxc,mg:GetFirst()+mg:GetNext())
										mg:Merge(mg2)
									end
								else if mg:GetCount()==0 then
										mg=g:FilterSelect(tp,f,minc,minc,nil)
									else
										if minc-2~=0 or maxc-2~=0 then	
										  local mg2=g:FilterSelect(tp,f,minc-2,maxc,mg:GetFirst())
										  mg:Merge(mg2)
										end
									end	
								end							 										
								c:SetMaterial(mg)	
								Duel.Overlay(c,mg)
							end
						else
							local mg=g:FilterSelect(tp,f,minc,maxc,nil)						
							c:SetMaterial(mg)	
							Duel.Overlay(c,mg)
						end
						end
					else
						local mg=g:FilterSelect(tp,f,minc,maxc,nil)						
						c:SetMaterial(mg)	
						Duel.Overlay(c,mg)						
					end		
				end
		end
end
function Auxiliary.XyzCondition2(f,minc,maxc,alterf,desc)
return	function(e,c,og)
				if c==nil then return true end
				local ft=Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)
				local ct=-ft
				local mt=Duel.GetFieldGroup(Duel.GetTurnPlayer(),LOCATION_MZONE,nil):Filter(Card.IsHasEffect,nil,100000350)
				if mt:GetCount()>0 then
				local m=minc-mt:GetCount()
					if m<=ct and minc>mt:GetCount() then return false end
					if og then
						return og:IsExists(f,minc,nil)
					else
						if ct<1 and Duel.IsExistingMatchingCard(alterf,c:GetControler(),LOCATION_MZONE,0,1,nil) then return true end
						local ms=mt:GetFirst()
						local g=Duel.GetXyzMaterial(c)
						while ms do
							if c:GetRank()==ms:GetLevel() and c:IsAttribute(ATTRIBUTE_WATER)  then							
								if m>0 then 
								return g:IsExists(f,m,nil)
								else
								return g:IsExists(f,1,nil)
								end
							else
								return g:IsExists(f,minc,nil)
							end	
							ms=mt:GetNext()
						end			
					end
				else
					if minc<=ct then return false end
					if og then
						return og:IsExists(f,minc,nil)
					else
						if ct<1 and Duel.IsExistingMatchingCard(alterf,c:GetControler(),LOCATION_MZONE,0,1,nil) then return true end
						local g=Duel.GetXyzMaterial(c)
						return g:IsExists(f,minc,nil)
					end
				end
			end
end
function Auxiliary.XyzOperation2(f,minc,maxc,alterf,desc,op)
	return	function(e,tp,eg,ep,ev,re,r,rp,c,og)
					local ft=Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)
					local ct=-ft
					local g=Duel.GetXyzMaterial(c)	
					local mt=Duel.GetFieldGroup(Duel.GetTurnPlayer(),LOCATION_MZONE,nil):Filter(Card.IsHasEffect,nil,100000350)
					
						local b1=g:IsExists(f,minc-mt:GetCount(),nil)
						local b2=ct<1 and Duel.IsExistingMatchingCard(alterf,tp,LOCATION_MZONE,0,1,nil)
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
					if (b1 and b2 and Duel.SelectYesNo(tp,desc)) or ((not b1) and b2) then
							local mg=Duel.SelectMatchingCard(tp,alterf,tp,LOCATION_MZONE,0,1,1,nil)
							local mg2=mg:GetFirst():GetOverlayGroup()
							if mg2:GetCount()~=0 then
								Duel.Overlay(c,mg2)
							end
							Duel.Overlay(c,mg)
							c:SetMaterial(mg)
							if op~=nil then op(e,tp) end
					else	
						if mt:GetCount()~=0 and c:IsAttribute(ATTRIBUTE_WATER)  then					
						local mp=mt:Filter(Card.GetLevel,nil,c:GetRank()):GetCount()
						if g:FilterCount(f,nil)==minc-mp then					
							local mg=g:Filter(f,nil):FilterSelect(tp,Card.IsHasEffect,mp,mp,nil,100000350)
							if minc-(mp*2)>0 then
								local mg2=g:FilterSelect(tp,f,minc-(mp*2),maxc-(mp*2),mg:GetFirst())
								mg:Merge(mg2)
							end										
							c:SetMaterial(mg)	
							Duel.Overlay(c,mg)
							if op~=nil then op(e,tp) end
						else if g:FilterCount(f,nil)>minc-mp and mp>0 then
							local mpt=mt:Filter(Card.GetLevel,nil,c:GetRank()):GetFirst()
							local mg=Group.CreateGroup()
							if mpt then
								if Duel.SelectYesNo(tp,aux.Stringid(100000350,0)) then
									mg:AddCard(mpt)
								end
								mpt=mt:Filter(Card.GetLevel,nil,c:GetRank()):GetNext()
								if mg and minc-1>mp and mpt and Duel.SelectYesNo(tp,aux.Stringid(100000350,0)) then
									mg:AddCard(mpt)
									if minc>mg:GetCount()*2 then
										local mg2=g:FilterSelect(tp,f,minc-4,maxc-4,mg:GetFirst()+mg:GetNext())
										mg:Merge(mg2)
									end
								else if mg:GetCount()==0 then
										mg=g:FilterSelect(tp,f,minc,minc,nil)
									else
										if minc-2~=0 or maxc-2~=0 then	
										local mg2=g:FilterSelect(tp,f,minc-2,maxc-2,mg:GetFirst())
										mg:Merge(mg2)
										end
									end	
								end							 										
								c:SetMaterial(mg)	
								Duel.Overlay(c,mg)
							end
							else 	
								local mg=g:FilterSelect(tp,f,minc,maxc,nil)						
								c:SetMaterial(mg)	
								Duel.Overlay(c,mg)				
							end
						end
						else
							local mg=g:FilterSelect(tp,f,minc,maxc,nil)
							c:SetMaterial(mg)
							Duel.Overlay(c,mg)
						end
					end
			end
end
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--XYZ
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(100000350)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)	
	e2:SetTarget(c100000350.target)
	c:RegisterEffect(e2)
end
function c100000350.target(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup() and not c:IsType(TYPE_XYZ)
end
